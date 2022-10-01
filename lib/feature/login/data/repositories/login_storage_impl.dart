import 'dart:convert';

import 'package:feature_oriented/core/error/exceptions.dart';
import 'package:feature_oriented/core/storage/shared_prefs_manager_impl.dart';
import 'package:feature_oriented/core/utils/logger.dart';
import 'package:feature_oriented/core/utils/shared_prefs_keys.dart';
import 'package:feature_oriented/feature/login/data/models/login_model.dart';

part 'login_storage.dart';

class LocalStorageLoginRepoImpl extends SharedPrefsManagerImpl
    implements LocalStorageLoginRepo {
  @override
  Future<void> cacheToken(LoginData data) {
    return saveIntoCache(SharedPrefsKeys.cachedToken, data);
  }

  @override
  Future<LoginData> getLastToken() {
    var cachedToken;
    try {
      LoggerUtils().makeLoggerInfo( 'before cachedToken $cachedToken');
      cachedToken = getCached(SharedPrefsKeys.cachedToken);
    } catch (e) {
      LoggerUtils().makeLoggerError( e.toString());
      throw CacheException();
    }

    return Future.value(LoginData.fromJson(cachedToken));
  }
}
