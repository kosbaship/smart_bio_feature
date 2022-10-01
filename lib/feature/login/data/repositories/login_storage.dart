part of 'login_storage_impl.dart';

abstract class LocalStorageLoginRepo {
  Future<LoginData> getLastToken();

  Future<void> cacheToken(LoginData data);
}
