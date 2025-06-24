import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/routes/app_routes.dart';
import '../../initialization.dart';
import '../utils/app_strings.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[AppStrings.contentType] = AppStrings.applicationJson;
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);

    if (response.statusCode == 401) {
      debugPrint('Unauthorized access detected. Redirecting to login.');
      notificationService?.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        Routes.loginRoute,
        (route) => false,
      );
    }
  }

  @override
  void onError(err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
