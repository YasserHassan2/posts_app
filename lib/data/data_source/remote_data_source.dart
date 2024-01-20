import '../network/app_api.dart';

abstract class RemoteDataSource {
  Future<Map> getPosts(int page);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<Map> getPosts(int page) async {
    return await _appServiceClient.getPosts(page);
  }
}
