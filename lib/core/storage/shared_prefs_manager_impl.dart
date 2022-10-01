import 'dart:convert';

import 'package:feature_oriented/app/injection_container.dart';
import 'package:feature_oriented/core/error/exceptions.dart';
import 'package:feature_oriented/core/utils/logger.dart';
import 'package:feature_oriented/core/utils/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_prefs_manager.dart';

class SharedPrefsManagerImpl extends SharedPrefsManager {
  @override
  Future<bool> saveIntoCache(String key, dynamic value) async =>
      await serviceLocator<SharedPreferences>()
          .setString(key, jsonEncode(value));

  @override
   getCached(String key) {
    if (hasCached(key)) {
      if (key == SharedPrefsKeys.cachedToken) {
        LoggerUtils().makeLoggerInfo('Adnan: ${jsonDecode(
          serviceLocator<SharedPreferences>().getString(key)!,
        ).runtimeType}');
      }
      return jsonDecode(
        serviceLocator<SharedPreferences>().getString(key)!,
      );
    } else {
      LoggerUtils().makeLoggerInfo('CacheException Get Cache key');
      throw CacheException();
    }
  }

  @override
  bool hasCached(String key) =>
      serviceLocator<SharedPreferences>().containsKey(key);

  @override
  Future<bool> clearCached(String key) async =>
      await serviceLocator<SharedPreferences>().remove(key);
}
