import 'package:dio/dio.dart';
import 'package:projectunity/rest/api_interceptor.dart';
import 'package:projectunity/utils/constant.dart';

Dio createDio() {
  Dio _dio = Dio(BaseOptions(
      baseUrl: baseUrl, connectTimeout: 30000, receiveTimeout: 30000));
  _dio.interceptors.add(ApiInterceptor());
  return _dio;
}