import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:projectunity/LoginRequestDataProvider/device_info_provider.dart';
import 'package:projectunity/services/network_api_service.dart';
import 'package:projectunity/utils/login_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ViewModel/login_vm.dart';

GetIt getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerLazySingleton<NetworkApiService>(() => NetworkApiService());
  getIt.registerLazySingleton<LoginVM>(() => LoginVM());
  getIt.registerLazySingleton(() => LoginRequestDataProvider());
  getIt.registerSingleton(createDio());
  getIt.registerLazySingletonAsync(() async => SharedPreferences.getInstance());
  getIt.registerLazySingleton(() => DeviceInfoPlugin());
}
