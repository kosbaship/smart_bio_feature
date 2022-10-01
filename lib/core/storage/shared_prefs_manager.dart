part of 'shared_prefs_manager_impl.dart';

abstract class SharedPrefsManager {
  Future<bool> saveIntoCache(String key, dynamic value);

  getCached(String key);

  bool hasCached(String key);

  Future<bool> clearCached(String key);
}
