import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:projectunity/LoginRequestDataProvider/device_info_provider.dart';
import 'package:projectunity/ViewModel/employee_list_bloc.dart';
import 'package:projectunity/services/employee_list_api_service.dart';
import 'package:projectunity/services/network_repository.dart';
import 'package:projectunity/services/login_api_service.dart';
import 'package:projectunity/services/sign_in_with_google.dart';
import 'package:projectunity/utils/login_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ViewModel/login_bloc.dart';

GetIt getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerLazySingleton<LoginApiService>(() => LoginApiService());
  getIt.registerLazySingleton<LoginModel>(() => LoginModel());
  getIt.registerLazySingleton(() => LoginRequestDataProvider());
  getIt.registerSingleton(createDio());
  getIt.registerLazySingletonAsync(() async => SharedPreferences.getInstance());
  getIt.registerLazySingleton(() => DeviceInfoPlugin());
  getIt.registerLazySingleton(() => NetworkRepository());
  getIt.registerLazySingleton(() => EmployeeListBloc());
  getIt.registerLazySingleton(() => EmployeeListApiService());
  getIt.registerLazySingleton(() => LoginBloc());
}
