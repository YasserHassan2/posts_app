part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class getPosts extends MainEvent {
  int page;
  getPosts({required this.page});
}
