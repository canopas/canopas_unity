import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/rest/dio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();

  @injectable
  Dio get dio => createDio();
}
