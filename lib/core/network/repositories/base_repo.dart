import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class BaseRepository {
  @protected
  Future<Response> getWithoutParams(
    String api, {
    Map<String, dynamic> params,
    bool external = false,
    Map<String, dynamic> headers,
  });

  @protected
  Future<Response> postWithParams(
    String api,
    dynamic params, {
    bool external = false,
    Map<String, dynamic> headers,
  });
}
