import 'package:feature_oriented/core/storage/shared_prefs_manager_impl.dart';
import 'package:feature_oriented/core/utils/shared_prefs_keys.dart';

abstract class HomeLocalDataSource {
  Future<bool> clearToken();
}

class HomeLocalDataSourceImpl extends SharedPrefsManagerImpl
    implements HomeLocalDataSource {
  @override
  Future<bool> clearToken() async {
    return await clearCached(SharedPrefsKeys.cachedToken);
  }
}
