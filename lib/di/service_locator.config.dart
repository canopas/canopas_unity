// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../Navigation/login_state.dart' as _i20;
import '../Navigation/navigation_stack_manager.dart' as _i5;
import '../ViewModel/employee_detail_bloc.dart' as _i12;
import '../ViewModel/employee_list_bloc.dart' as _i14;
import '../ViewModel/login_bloc.dart' as _i15;
import '../ViewModel/team_leaves_bloc.dart' as _i22;
import '../ViewModel/user_leaves_bloc.dart' as _i23;
import '../rest/api_interceptor.dart' as _i8;
import '../services/EmployeeApiService/employee_detail_api_service.dart'
    as _i11;
import '../services/EmployeeApiService/employee_list_api_service.dart' as _i13;
import '../services/LeaveService/apply_for_leaves_api_service.dart' as _i19;
import '../services/LeaveService/team_leaves_api_service.dart' as _i16;
import '../services/LeaveService/user_leaves_api_service.dart' as _i17;
import '../services/auth_manager.dart' as _i9;
import '../services/auth_service.dart' as _i3;
import '../services/employee_service.dart' as _i4;
import '../services/network_repository.dart' as _i21;
import '../user/user_manager.dart' as _i18;
import '../user/user_preference.dart' as _i7;
import 'AppModule.dart' as _i24; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.singleton<_i3.AuthService>(_i3.AuthService());
  gh.singleton<_i4.EmployeeService>(_i4.EmployeeService());
  gh.singleton<_i5.NavigationStackManager>(_i5.NavigationStackManager());
  await gh.factoryAsync<_i6.SharedPreferences>(() => appModule.preferences,
      preResolve: true);
  gh.factory<_i7.UserPreference>(
      () => _i7.UserPreference(get<_i6.SharedPreferences>()));
  gh.singleton<_i8.ApiInterceptor>(
      _i8.ApiInterceptor(get<_i7.UserPreference>()));
  gh.singleton<_i9.AuthManager>(
      _i9.AuthManager(get<_i7.UserPreference>(), get<_i3.AuthService>()));
  gh.singleton<_i10.Dio>(appModule.dio(get<_i8.ApiInterceptor>()));
  gh.factory<_i11.EmployeeDetailApiService>(() => _i11.EmployeeDetailApiService(
      get<_i10.Dio>(), get<_i7.UserPreference>()));
  gh.singleton<_i12.EmployeeDetailBloc>(
      _i12.EmployeeDetailBloc(get<_i4.EmployeeService>()));
  gh.factory<_i13.EmployeeListApiService>(() =>
      _i13.EmployeeListApiService(get<_i10.Dio>(), get<_i7.UserPreference>()));
  gh.singleton<_i14.EmployeeListBloc>(
      _i14.EmployeeListBloc(get<_i4.EmployeeService>()));
  gh.singleton<_i15.LoginBloc>(_i15.LoginBloc(get<_i9.AuthManager>()));
  gh.singleton<_i16.TeamLeavesApiService>(
      _i16.TeamLeavesApiService(get<_i10.Dio>(), get<_i7.UserPreference>()));
  gh.singleton<_i17.UserLeavesApiService>(
      _i17.UserLeavesApiService(get<_i10.Dio>(), get<_i7.UserPreference>()));
  gh.singleton<_i18.UserManager>(_i18.UserManager(get<_i7.UserPreference>()));
  gh.singleton<_i19.ApplyForLeaveApiService>(
      _i19.ApplyForLeaveApiService(get<_i10.Dio>(), get<_i7.UserPreference>()));
  gh.singleton<_i20.LoginState>(_i20.LoginState(get<_i18.UserManager>()));
  gh.factory<_i21.NetworkRepository>(() => _i21.NetworkRepository(
      get<_i13.EmployeeListApiService>(),
      get<_i11.EmployeeDetailApiService>(),
      get<_i17.UserLeavesApiService>(),
      get<_i16.TeamLeavesApiService>()));
  gh.singleton<_i22.TeamLeavesBloc>(
      _i22.TeamLeavesBloc(get<_i21.NetworkRepository>()));
  gh.singleton<_i23.UserLeavesBloc>(
      _i23.UserLeavesBloc(get<_i21.NetworkRepository>()));
  return get;
}

class _$AppModule extends _i24.AppModule {}
