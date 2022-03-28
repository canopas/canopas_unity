// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../ViewModel/employee_list_bloc.dart' as _i12;
import '../ViewModel/login_bloc.dart' as _i13;
import '../services/employee_list_api_service.dart' as _i8;
import '../services/login/login_api_service.dart' as _i9;
import '../services/login/login_request_provider.dart' as _i4;
import '../services/login/login_service.dart' as _i5;
import '../services/network_repository.dart' as _i10;
import '../user/user_manager.dart' as _i11;
import '../user/user_preference.dart' as _i7;
import 'AppModule.dart' as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.Dio>(() => appModule.dio);
  gh.factory<_i4.LoginRequestDataProvider>(
      () => _i4.LoginRequestDataProvider());
  gh.factory<_i5.LoginService>(
      () => _i5.LoginService(get<_i4.LoginRequestDataProvider>()));
  await gh.factoryAsync<_i6.SharedPreferences>(() => appModule.preferences,
      preResolve: true);
  gh.factory<_i7.UserPreference>(
      () => _i7.UserPreference(get<_i6.SharedPreferences>()));
  gh.factory<_i8.EmployeeListApiService>(() =>
      _i8.EmployeeListApiService(get<_i3.Dio>(), get<_i7.UserPreference>()));
  gh.factory<_i9.LoginApiService>(() => _i9.LoginApiService(
      get<_i7.UserPreference>(), get<_i3.Dio>(), get<_i5.LoginService>()));
  gh.factory<_i10.NetworkRepository>(() => _i10.NetworkRepository(
      get<_i9.LoginApiService>(), get<_i8.EmployeeListApiService>()));
  gh.singleton<_i11.UserManager>(_i11.UserManager(get<_i7.UserPreference>()));
  gh.singleton<_i12.EmployeeListBloc>(
      _i12.EmployeeListBloc(get<_i10.NetworkRepository>()));
  gh.singleton<_i13.LoginBloc>(_i13.LoginBloc(get<_i10.NetworkRepository>()));
  return get;
}

class _$AppModule extends _i14.AppModule {}
