part of 'login_remote_impl.dart';

abstract class LoginRemoteRepo {
  Future<LoginData> loginUser(LoginParams params);

  Future<bool> checkTokenValidation();
}
