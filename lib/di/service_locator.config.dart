// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../ViewModel/all_leaves_user_bloc.dart' as _i15;
import '../ViewModel/employee_detail_bloc.dart' as _i16;
import '../ViewModel/employee_list_bloc.dart' as _i17;
import '../ViewModel/login_bloc.dart' as _i18;
import '../services/EmployeeApiService/employee_detail_api_service.dart' as _i9;
import '../services/EmployeeApiService/employee_list_api_service.dart' as _i10;
import '../services/LeaveService/apply_for_leaves_api_service.dart' as _i8;
import '../services/LeaveService/logged_in_user_api_service.dart' as _i12;
import '../services/login/login_api_service.dart' as _i11;
import '../services/login/login_request_provider.dart' as _i4;
import '../services/login/login_service.dart' as _i5;
import '../services/network_repository.dart' as _i14;
import '../user/user_manager.dart' as _i13;
import '../user/user_preference.dart' as _i7;
import 'AppModule.dart' as _i19; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i8.ApplyForLeaveApiService>(
      _i8.ApplyForLeaveApiService(get<_i3.Dio>(), get<_i7.UserPreference>()));
  gh.factory<_i9.EmployeeDetailApiService>(() =>
      _i9.EmployeeDetailApiService(get<_i3.Dio>(), get<_i7.UserPreference>()));
  gh.factory<_i10.EmployeeListApiService>(() =>
      _i10.EmployeeListApiService(get<_i3.Dio>(), get<_i7.UserPreference>()));
  gh.factory<_i11.LoginApiService>(() => _i11.LoginApiService(
      get<_i7.UserPreference>(), get<_i3.Dio>(), get<_i5.LoginService>()));
  gh.singleton<_i12.UserLeavesApiService>(
      _i12.UserLeavesApiService(get<_i3.Dio>(), get<_i7.UserPreference>()));
  gh.singleton<_i13.UserManager>(_i13.UserManager(get<_i7.UserPreference>()));
  gh.factory<_i14.NetworkRepository>(() => _i14.NetworkRepository(
      get<_i11.LoginApiService>(),
      get<_i10.EmployeeListApiService>(),
      get<_i9.EmployeeDetailApiService>(),
      get<_i12.UserLeavesApiService>()));
  gh.singleton<_i15.AllLeavesUserBloc>(
      _i15.AllLeavesUserBloc(get<_i14.NetworkRepository>()));
  gh.singleton<_i16.EmployeeDetailBloc>(
      _i16.EmployeeDetailBloc(get<_i14.NetworkRepository>()));
  gh.singleton<_i17.EmployeeListBloc>(
      _i17.EmployeeListBloc(get<_i14.NetworkRepository>()));
  gh.singleton<_i18.LoginBloc>(_i18.LoginBloc(get<_i14.NetworkRepository>()));
  return get;
}

class _$AppModule extends _i19.AppModule {}
