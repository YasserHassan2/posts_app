import 'dart:core';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../app/constants.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET(Endpoints.posts)
  Future<dynamic> getPosts(
    @Query('page') int page,
  );
}
