import 'package:dartz/dartz.dart';
import 'package:posts_app/domain/model/post_model.dart';

import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.getPosts();
        List<PostModel> posts = [];
        if (response["data"] != null) {
          posts = List<PostModel>.from(
              response["data"].map((x) => PostModel.fromJson(x)));
          return Right(posts);
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response["error"] ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
