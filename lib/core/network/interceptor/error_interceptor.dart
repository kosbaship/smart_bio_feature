import 'package:dio/dio.dart' as dio;
class ErrorInterceptor extends dio.InterceptorsWrapper {
  @override
  Future onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) async =>
      super.onRequest(options, handler);

  @override
  Future onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) async =>
      super.onResponse(response, handler);

  // @override
  // void onError(
  //   dio.DioError err,
  //   dio.ErrorInterceptorHandler handler,
  // ) {
  //   switch (err.type) {
  //     case dio.DioErrorType.cancel:
  //       throw RequestCanceledException();
  //     case dio.DioErrorType.connectTimeout:
  //       throw RequestConnectTimeoutException();
  //     case dio.DioErrorType.other:
  //       throw NoInternetConnectionException();
  //     case dio.DioErrorType.receiveTimeout:
  //       throw RequestReceiveTimeoutException();
  //     case dio.DioErrorType.sendTimeout:
  //       throw RequestSendTimeoutException();
  //     case dio.DioErrorType.response:
  //       if (err.response!.statusCode == 401) {
  //         throw UserUnAuthenticatedException();
  //       } else if (err.response!.statusCode == 403) {
  //         throw UserUnAuthorizedException();
  //       }
  //   }
  //   super.onError(err, handler);
  // }
}
