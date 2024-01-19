part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainSuccess extends MainState {
  final List<PostModel> listOfPosts;

  MainSuccess(this.listOfPosts);
}

class MainFailure extends MainState {
  final String message;
  final String code;

  MainFailure(this.message, this.code);
}
