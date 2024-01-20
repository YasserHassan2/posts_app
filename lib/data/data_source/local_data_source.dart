import '../../domain/model/post_model.dart';
import '../network/error_handler.dart';

const CACHE_MAIN_KEY = "CACHE_MAIN_KEY";
const CACHE_MAIN_INTERVAL = 60 * 1000; // 1 minute cache in millis

abstract class LocalDataSource {
  Future<List<PostModel>> getMainData();

  Future<void> saveMainDataToCache(List<PostModel> postsList);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<List<PostModel>> getMainData() async {
    CachedItem? cachedItem = cacheMap[CACHE_MAIN_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_MAIN_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveMainDataToCache(List<PostModel> postList) async {
    cacheMap[CACHE_MAIN_KEY] = CachedItem(postList);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    // expirationTimeInMillis -> 60 sec
    // currentTimeInMillis -> 1:00:00
    // cacheTime -> 12:59:30
    // valid -> till 1:00:30
    return isValid;
  }
}
