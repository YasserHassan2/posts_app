import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/domain/model/post_model.dart';

import '../../../app/app_database.dart';
import '../../../app/di.dart';
import '../../../domain/database_entities/post_entity.dart';
import '../../../domain/usecase/posts_usecase.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<getPosts>(_getPosts);
  }

  FutureOr<void> _getPosts(getPosts event, Emitter<MainState> emit) async {
    emit(MainLoading());
    final database =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final postsDao = database.postsDao;

    try {
      // check if there any data in posts local database
      List<PostEntity> postsList = await postsDao.findAllPosts();
      if (postsList.isNotEmpty) {
        // emit(MainSuccess(postsList));
      } else {
        PostsUseCase postsUseCase = instance<PostsUseCase>();

        (await postsUseCase.execute(PostsInput())).fold(
                (failure) =>
            {
              // left -> failure
              //emit failure state
              emit(MainFailure(
                  failure.message.toString(), failure.code.toString()))
            }, (listOfPosts) async {
          // right -> data (success)
          // content
          // emit success state
          List<PostEntity> postsList = [];
          listOfPosts.forEach((element) {
            postsList.add(PostEntity(
                element.id,
                element.image,
                element.likes,
                element.text,
                element.publishDate.toString(),
                element.owner.firstName,
                element.owner.lastName,
                element.image));
          });

          //save posts to local database
          postsList.forEach((element) async {
            await postsDao.insertPost(element);
          });

          emit(MainSuccess(listOfPosts));
        });
      }
    } catch (e) {
      PostsUseCase postsUseCase = instance<PostsUseCase>();

      (await postsUseCase.execute(PostsInput())).fold(
              (failure) =>
          {
            // left -> failure
            //emit failure state
            emit(MainFailure(
                failure.message.toString(), failure.code.toString()))
          }, (listOfPosts) async {
        // right -> data (success)
        // content
        // emit success state
        List<PostEntity> postsList = [];
        listOfPosts.forEach((element) {
          postsList.add(PostEntity(
              element.id,
              element.image,
              element.likes,
              element.text,
              element.publishDate.toString(),
              element.owner.firstName,
              element.owner.lastName,
              element.image));
        });

        emit(MainSuccess(listOfPosts));

        await Future.forEach(postsList, (PostEntity post) async {
          postsDao.insertPost(post);
        });

      });
    }
  }
}
