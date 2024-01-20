import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/domain/model/post_model.dart';
import 'package:posts_app/utils/ext/date_ext.dart';

import '../../../app/extensions.dart';
import '../../../domain/database_entities/post_entity.dart';
import '../../../utils/dialogs/custom_dialog.dart';
import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/font_manager.dart';
import '../../../utils/resources/strings_manager.dart';
import '../../../utils/resources/styles_manager.dart';
import '../../../utils/resources/values_manager.dart';
import '../../common/widgets/custom_language_widget.dart';
import '../../common/widgets/custom_network_image_widget.dart';
import '../../common/widgets/custom_scaffold.dart';
import '../../common/widgets/page_builder.dart';
import '../bloc/main_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _displayLoadingIndicator = false;
  List<PostModel> posts = [];
  int page = 1;

  void startLoading() {
    setState(() {
      _displayLoadingIndicator = true;
    });
  }

  void stopLoading() {
    setState(() {
      _displayLoadingIndicator = false;
    });
  }

  @override
  void initState() {
    BlocProvider.of<MainBloc>(context).add(getPosts(page: page));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageBuilder: PageBuilder(
          appbar: true,
          resizeToAvoidBottomInsets: true,
          allowBackButtonInAppBar: false,
          context: context,
          body: _getContentWidget(context),
          scaffoldKey: _key,
          appBarActions: [LanguageWidget()],
          displayLoadingIndicator: _displayLoadingIndicator,
          appBarTitle: AppStrings.popularPosts.tr()),
    );
  }

  Widget _getContentWidget(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state is MainLoading) {
          startLoading();
        } else {
          stopLoading();
        }
        if (state is MainSuccess) {
          this.posts.addAll(state.listOfPosts);
          page++;
        }

        if (state is MainFailure) {
          CustomDialog(context).showErrorDialog('', '', state.message);
        }
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            // User has reached the end of the list
            // Load more data or trigger pagination in flutter
            BlocProvider.of<MainBloc>(context).add(getPosts(page: page));
          }
          return false;
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppSize.s12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              posts.isNotEmpty
                  ? Expanded(child: PostsListWidget(posts))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget PostsListWidget(List<PostModel> postsList) {
    return ListView.builder(
      key: GlobalKey(debugLabel: "listView"),
      itemCount: postsList.length, // Add 1 for loading indicator
      itemBuilder: (context, index) {
        return postItemWidget(postsList[index]);
      },
    );
  }

  Widget postItemWidget(PostModel postModel) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              width: AppSize.s90,
              child: CustomNetworkImageWidget(imageUrl: postModel.image),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postModel.text ?? "",
                      textAlign: TextAlign.start,
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: FontSize.s14),
                    ),
                    Text(
                      postModel.likes.toString() + "likes",
                      textAlign: TextAlign.start,
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: FontSize.s12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          postModel.owner.firstName +
                                  " " +
                                  postModel.owner.lastName ??
                              "-",
                          textAlign: TextAlign.start,
                          style: getRegularStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14),
                        ),
                        Text(
                          timeAgo(postModel.publishDate) ?? "-",
                          textAlign: TextAlign.start,
                          style: getRegularStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
