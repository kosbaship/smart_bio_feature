import 'package:dartz/dartz.dart';
import 'package:feature_oriented/core/error/failures.dart';
import 'package:feature_oriented/core/usecases/usecase.dart';
import 'package:feature_oriented/feature/login/data/models/login_model.dart';
import 'package:feature_oriented/feature/login/domain/business/login_business_impl.dart';
import 'package:feature_oriented/feature/login/domain/entities/login_params.dart';

class LoginUser implements UseCase<LoginData, LoginParams> {
  final LoginBusiness loginBusiness;

  LoginUser({required this.loginBusiness});

  @override
  Future<Either<Failure, LoginData>> call(LoginParams params) async {
    return await loginBusiness.loginUser(params);
  }
}
