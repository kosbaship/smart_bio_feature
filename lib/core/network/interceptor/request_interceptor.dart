import 'package:dio/dio.dart' as dio;
import 'package:feature_oriented/app/injection_container.dart';
import 'package:feature_oriented/feature/login/data/repositories/login_storage_impl.dart';

class RequestInterceptor extends dio.InterceptorsWrapper {
  @override
  Future onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) async {
    bool hasTokenCached;
    try {
      await serviceLocator<LocalStorageLoginRepo>().getLastToken();
      hasTokenCached = true;
    } catch (e) {
      hasTokenCached = false;
    }
    options.headers['Content-type'] = 'application/json';
    if (hasTokenCached) {
      options.headers['Authorization'] =
          'Bearer ${(await serviceLocator<LocalStorageLoginRepo>().getLastToken()).token}';
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) async {
    return super.onResponse(response, handler);
  }
}
