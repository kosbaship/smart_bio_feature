import 'package:feature_oriented/app/injection_container.dart';
import 'package:feature_oriented/core/network/interceptor/error_interceptor.dart';
import 'package:feature_oriented/core/network/interceptor/request_interceptor.dart';
import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import 'package:feature_oriented/core/network/repositories/base_repo.dart';

class BaseRepoImpl implements BaseRepository {
  Dio? dio;

  BaseRepoImpl() : super() {
    BaseOptions options = BaseOptions(
      receiveTimeout: 300000,
      connectTimeout: 300000,
      followRedirects: false,
    );
    dio = Dio(options);
    dio!.interceptors.clear();
    dio!.interceptors.addAll([
      serviceLocator<RequestInterceptor>(),
      serviceLocator<ErrorInterceptor>()
    ]);
  }

  @protected
  @override
  Future<Response> postWithParams(
    String api,
    dynamic params, {
    bool external = false,
    Map<String, dynamic>? headers,
  }) async {
    return dio!.post(api,
        data: params,
        options: Options(
          extra: {
            "external": external,
          },
          headers: headers,
        ));
    // try {
    //   return dio!.post(api,
    //       data: params,
    //       options: Options(
    //         extra: {
    //           "external": external,
    //         },
    //         headers: headers,
    //       ));
    // } catch (e) {
    //   LoggerUtils()
    //       .makeLoggerError("postWithParams " + e.runtimeType.toString());
    //   rethrow;
    // }
  }

  @override
  Future<Response> getWithoutParams(
    String api, {
    Map<String, dynamic>? params,
    bool external = false,
    Map<String, dynamic>? headers,
  }) async {
    return await dio!.get(api,
        options: Options(
          extra: {
            "external": external,
          },
          headers: headers,
        ));
    // try {
    //   return await dio!.get(api,
    //       options: Options(
    //         extra: {
    //           "external": external,
    //         },
    //         headers: headers,
    //       ));
    // } catch (e) {
    //   LoggerUtils().makeLoggerError("postWithParams " + e.runtimeType.toString());
    //   rethrow;
    // }
  }
}
