// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import '../Navigation/login_state.dart' as _i16;
import '../Navigation/navigation_stack_manager.dart' as _i3;
import '../ViewModel/employee_detail_bloc.dart' as _i20;
import '../ViewModel/employee_list_bloc.dart' as _i21;
import '../ViewModel/login_bloc.dart' as _i15;
import '../ViewModel/team_leaves_bloc.dart' as _i18;
import '../ViewModel/user_leaves_bloc.dart' as _i19;
import '../rest/api_interceptor.dart' as _i6;
import '../services/EmployeeApiService/employee_detail_api_service.dart' as _i8;
import '../services/EmployeeApiService/employee_list_api_service.dart' as _i9;
import '../services/LeaveService/apply_for_leaves_api_service.dart' as _i13;
import '../services/LeaveService/team_leaves_api_service.dart' as _i10;
import '../services/LeaveService/user_leaves_api_service.dart' as _i11;
import '../services/auth_manager.dart' as _i14;
import '../services/network_repository.dart' as _i17;
import '../user/user_manager.dart' as _i12;
import '../user/user_preference.dart' as _i5;
import 'AppModule.dart' as _i22; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.singleton<_i3.NavigationStackManager>(_i3.NavigationStackManager());
  await gh.factoryAsync<_i4.SharedPreferences>(() => appModule.preferences,
      preResolve: true);
  gh.factory<_i5.UserPreference>(
      () => _i5.UserPreference(get<_i4.SharedPreferences>()));
  gh.singleton<_i6.ApiInterceptor>(
      _i6.ApiInterceptor(get<_i5.UserPreference>()));
  gh.singleton<_i7.Dio>(appModule.dio(get<_i6.ApiInterceptor>()));
  gh.factory<_i8.EmployeeDetailApiService>(() =>
      _i8.EmployeeDetailApiService(get<_i7.Dio>(), get<_i5.UserPreference>()));
  gh.factory<_i9.EmployeeListApiService>(() =>
      _i9.EmployeeListApiService(get<_i7.Dio>(), get<_i5.UserPreference>()));
  gh.singleton<_i10.TeamLeavesApiService>(
      _i10.TeamLeavesApiService(get<_i7.Dio>(), get<_i5.UserPreference>()));
  gh.singleton<_i11.UserLeavesApiService>(
      _i11.UserLeavesApiService(get<_i7.Dio>(), get<_i5.UserPreference>()));
  gh.singleton<_i12.UserManager>(_i12.UserManager(get<_i5.UserPreference>()));
  gh.singleton<_i13.ApplyForLeaveApiService>(
      _i13.ApplyForLeaveApiService(get<_i7.Dio>(), get<_i5.UserPreference>()));
  gh.singleton<_i14.AuthManager>(
      _i14.AuthManager(get<_i5.UserPreference>(), get<_i7.Dio>()));
  gh.singleton<_i15.LoginBloc>(_i15.LoginBloc(get<_i14.AuthManager>()));
  gh.singleton<_i16.LoginState>(_i16.LoginState(get<_i12.UserManager>()));
  gh.factory<_i17.NetworkRepository>(() => _i17.NetworkRepository(
      get<_i9.EmployeeListApiService>(),
      get<_i8.EmployeeDetailApiService>(),
      get<_i11.UserLeavesApiService>(),
      get<_i10.TeamLeavesApiService>()));
  gh.singleton<_i18.TeamLeavesBloc>(
      _i18.TeamLeavesBloc(get<_i17.NetworkRepository>()));
  gh.singleton<_i19.UserLeavesBloc>(
      _i19.UserLeavesBloc(get<_i17.NetworkRepository>()));
  gh.singleton<_i20.EmployeeDetailBloc>(
      _i20.EmployeeDetailBloc(get<_i17.NetworkRepository>()));
  gh.singleton<_i21.EmployeeListBloc>(
      _i21.EmployeeListBloc(get<_i17.NetworkRepository>()));
  return get;
}

class _$AppModule extends _i22.AppModule {}
