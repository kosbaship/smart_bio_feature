import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:feature_oriented/core/error/failures.dart';
import 'package:feature_oriented/feature/login/data/models/login_model.dart';
import 'package:feature_oriented/core/network/connection/internet_info_impl.dart';
import 'package:feature_oriented/core/utils/logger.dart';
import 'package:feature_oriented/feature/login/data/repositories/login_storage_impl.dart';
import 'package:feature_oriented/feature/login/data/repositories/login_remote_impl.dart';
import 'package:feature_oriented/feature/login/domain/entities/login_params.dart';

part 'login_business.dart';

class LoginBusinessImpl implements LoginBusiness {
  late final LoginRemoteRepo remoteLoginRepo;
  late final LocalStorageLoginRepo localLoginRepo;
  late final NetworkInfo networkInfo;

  LoginBusinessImpl({
    required this.remoteLoginRepo,
    required this.localLoginRepo,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, LoginData>> loginUser(LoginParams params) async {
    try {
      final remoteData = await remoteLoginRepo.loginUser(params);
      await localLoginRepo.cacheToken(remoteData);
      return Right(remoteData);
    } catch (e) {
      return Left(CustomFailure(message: e.runtimeType.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginData>> fetchCachedToken() async {
    try {
      final localData = await localLoginRepo.getLastToken();
      return Right(localData);
    } catch (e) {
      return Left(CustomFailure(message: e.runtimeType.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkTokenValidation(String token) async {
    try {
      final remoteData = await remoteLoginRepo.checkTokenValidation();
      return Right(remoteData);
    } on DioError catch (dioError) {
      switch (dioError.type) {
        case DioErrorType.cancel:
          return const Left(RequestCanceledFailure());
        case DioErrorType.connectTimeout:
          return const Left(RequestConnectTimeoutFailure());
        case DioErrorType.other:
          return const Left(NoInternetConnectionFailure());
        case DioErrorType.receiveTimeout:
          return const Left(RequestReceiveTimeoutFailure());
        case DioErrorType.sendTimeout:
          return const Left(RequestSendTimeoutFailure());
        case DioErrorType.response:
          if (dioError.response!.statusCode == 401) {
            return const Left(UserUnAuthenticatedFailure());
          } else if (dioError.response!.statusCode == 403) {
            return const Left(UserUnAuthorizedFailure());
          } else {
            return Left(CustomFailure(message: dioError.runtimeType.toString()));
          }
      }
    } catch (error) {
      return Left(CustomFailure(message: error.runtimeType.toString()));
    }
  }
}
