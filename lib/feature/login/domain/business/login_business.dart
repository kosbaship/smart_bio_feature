part of 'login_business_impl.dart';

abstract class LoginBusiness {
  Future<Either<Failure, LoginData>> loginUser(LoginParams params);

  Future<Either<Failure, LoginData>> fetchCachedToken();

  Future<Either<Failure, bool>> checkTokenValidation(String token);
}

