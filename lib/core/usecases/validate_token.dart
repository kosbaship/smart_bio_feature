import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_oriented/core/error/failures.dart';
import 'package:feature_oriented/core/usecases/usecase.dart';
import 'package:feature_oriented/feature/login/domain/business/login_business_impl.dart';

class ValidateToken implements UseCase<bool, TokenValidationParams> {
  final LoginBusiness loginBusiness;

  ValidateToken({required this.loginBusiness});

  @override
  Future<Either<Failure, bool>> call(TokenValidationParams params) async {
    return await loginBusiness.checkTokenValidation(params.token);
  }
}

class TokenValidationParams extends Equatable {
  final String token;

  const TokenValidationParams(this.token);

  @override
  List<Object?> get props => [token];
}
