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
    PostsUseCase postsUseCase = instance<PostsUseCase>();
    (await postsUseCase.execute(PostsInput(event.page))).fold(
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

      emit(MainSuccess(listOfPosts));
    });
  }
}