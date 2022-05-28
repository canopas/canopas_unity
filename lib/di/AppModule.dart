import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/rest/api_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/Constant/api_constant.dart';

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();

  // @injectable
  // Dio get dio => createDio(ApiInterceptor());

  @singleton
  Dio dio(ApiInterceptor interceptor) {
    Dio _dio = Dio(BaseOptions(
        baseUrl: baseUrl, connectTimeout: 30000, receiveTimeout: 30000));
    _dio.interceptors.add(interceptor);
    return _dio;
  }
}
