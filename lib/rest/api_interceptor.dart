import 'dart:async';

import 'package:dio/dio.dart';

const AUTH_REQUEST_CODE_UNAUTHORIZED = 401;

class ApiInterceptor extends Interceptor {
  final networkError = "No Interner connection!";
  final serverError = "Something went wrong";

  @override
  FutureOr<dynamic> onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;

    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return Exception(networkError);
      case DioErrorType.response:
        if (statusCode == AUTH_REQUEST_CODE_UNAUTHORIZED) {
          return err.response;
        }
        return Exception(serverError);
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        return Exception(networkError);
    }
  }
}
