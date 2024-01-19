import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/post_model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class PostsUseCase implements BaseUseCase<PostsInput, List<PostModel>> {
  final Repository _repository;

  PostsUseCase(this._repository);

  @override
  Future<Either<Failure, List<PostModel>>> execute(PostsInput input) async {
    return await _repository.getPosts();
  }
}

class PostsInput {}
