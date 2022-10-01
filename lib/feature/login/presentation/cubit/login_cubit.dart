import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_oriented/core/error/failures.dart';
import 'package:feature_oriented/core/usecases/validate_token.dart';
import 'package:feature_oriented/core/usecases/fetch_token.dart';
import 'package:feature_oriented/core/utils/constants.dart';
import 'package:feature_oriented/core/utils/logger.dart';
import 'package:feature_oriented/feature/login/data/models/login_model.dart';
import 'package:feature_oriented/feature/login/domain/entities/login_params.dart';
import 'package:feature_oriented/feature/login/domain/usecases/login_user.dart';
import 'package:flutter/foundation.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.fetchToken,
    required this.loginUser,
    required this.checkTokenValidation,
  }) : super(NotLoggedState()) {
    checkLogin();
  }

  final LoginUser loginUser;
  final FetchToken fetchToken;
  final ValidateToken checkTokenValidation;

  void checkLogin() async {

    emit(LoadingState());
    final result = await fetchToken(TokenParams());

    result.fold((failure) {

      emit(NotLoggedState());
    }, (success) async {
      final isValid = await checkTokenValidation(
        TokenValidationParams(success.token),
      );
      isValid.fold((fail) {
        LoggerUtils()
            .makeLoggerError('LoginCubit: Token Can Not Fetched => $fail');
        emit(NotLoggedState());
      }, (_) {
        LoggerUtils()
            .makeLoggerInfo('LoginCubit: Token is  => \n${success.token}');
        emit(LoggedState(
          login: LoginData(user: success.user, token: success.token),
        ));
      });
    });
  }

  void signInUser({required email, required password}) async {
    emit(LoadingState());
    final result = await loginUser(
      LoginParams(username: email, password: password),
    );
    result.fold((failure) {
      LoggerUtils()
          .makeLoggerError('LoginCubit: signInUser => $failure');
        emit(const ErrorState(message: loginErrorMessage));

    }, (success) {
      emit(LoggedState(
          login: LoginData(user: success.user, token: success.token)));
    });
  }
}
