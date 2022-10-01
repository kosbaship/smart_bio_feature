import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_oriented/core/error/failures.dart';
import 'package:feature_oriented/core/usecases/usecase.dart';
import 'package:feature_oriented/feature/login/data/models/login_model.dart';
import 'package:feature_oriented/feature/login/domain/business/login_business_impl.dart';

class FetchToken implements UseCase<LoginData, TokenParams> {
  final LoginBusiness loginBusiness;

  FetchToken({required this.loginBusiness});

  @override
  Future<Either<Failure, LoginData>> call(TokenParams params) async {
    return await loginBusiness.fetchCachedToken();
  }
}

class TokenParams extends Equatable {
  @override
  List<Object?> get props => [];
}
