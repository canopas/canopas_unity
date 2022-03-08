import 'package:dio/dio.dart';
import 'package:projectunity/utils/constant.dart';

Dio createDio() {
  var _dio= Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 50000,
      receiveTimeout: 3000));
  _dio.interceptors.add(LoginInterceptor());
  return _dio;
}

class LoginInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.response) {
      throw Exception('caught!');
    }
    if (err.type == DioErrorType.connectTimeout) {
      throw Exception('check your connection');
    }
    if (err.type == DioErrorType.other) {
      throw Exception('something went wrong');
    }
    if (err.type == DioErrorType.receiveTimeout) {
      throw Exception('unable to connect to the server');
    }
    throw Exception(err.toString());
  }
}
