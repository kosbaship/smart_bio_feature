import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class CustomFailure extends Failure {
  const CustomFailure({required this.message});

  final String message;

  @override
  String toString() {
    return 'Failure{message: $message}';
  }
}

class NoInternetConnectionFailure extends Failure {
  final String message =
      'Connection to API server failed due to internet connection';

  const NoInternetConnectionFailure();
}

class RequestCanceledFailure extends Failure {
  final String message = 'Request to API server was cancelled';

  const RequestCanceledFailure();
}

class RequestConnectTimeoutFailure extends Failure {
  final String message = 'Connection timeout with API server';

  const RequestConnectTimeoutFailure();
}

class RequestSendTimeoutFailure extends Failure {
  final String message = 'Send timeout in connection with API server';

  const RequestSendTimeoutFailure();
}

class RequestReceiveTimeoutFailure extends Failure {
  final String message = 'Receive timeout in connection with API server';

  const RequestReceiveTimeoutFailure();
}

class UserUnAuthorizedFailure extends Failure {
  final String message = 'User UnAuthorized with API server';

  const UserUnAuthorizedFailure();
}

class UserUnAuthenticatedFailure extends Failure {
  final String message = 'User UnAuthenticated with API server';

  const UserUnAuthenticatedFailure();
}
