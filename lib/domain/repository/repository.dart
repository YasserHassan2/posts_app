import 'package:dartz/dartz.dart';
import 'package:posts_app/domain/model/post_model.dart';

import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, List<PostModel>>> getPosts(int page);
}
