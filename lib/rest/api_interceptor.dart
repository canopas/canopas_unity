import 'dart:async';

import 'package:dio/dio.dart';

import 'package:projectunity/utils/data_exception.dart';


class ApiInterceptor extends Interceptor {
  final networkError = "No Internet connection!";
  final serverError = "Something went wrong";

  @override
  FutureOr<dynamic> onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;

    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        throw DataException(networkError);
      case DioErrorType.response:
        if (statusCode != 200) {
          throw DataException(serverError);
        }
        throw DataException(serverError);
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw DataException(networkError);
    }
  }
}
