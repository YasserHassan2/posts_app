
import '../network/app_api.dart';

abstract class RemoteDataSource {
  Future<Map> getPosts();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<Map> getPosts() async {
    return await _appServiceClient.getPosts();
  }
}
