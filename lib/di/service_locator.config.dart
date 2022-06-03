// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../navigation/login_state.dart' as _i18;
import '../navigation/navigation_stack_manager.dart' as _i5;
import '../rest/api_interceptor.dart' as _i8;
import '../services/auth_manager.dart' as _i9;
import '../services/auth_service.dart' as _i3;
import '../services/employee_service.dart' as _i4;
import '../services/leave/apply_for_leaves_api_service.dart' as _i17;
import '../services/leave/team_leaves_api_service.dart' as _i14;
import '../services/leave/user_leaves_api_service.dart' as _i15;
import '../services/network_repository.dart' as _i19;
import '../user/user_manager.dart' as _i16;
import '../user/user_preference.dart' as _i7;
import '../viewmodel/employee_detail_bloc.dart' as _i11;
import '../viewmodel/employee_list_bloc.dart' as _i12;
import '../viewmodel/login_bloc.dart' as _i13;
import '../viewmodel/team_leaves_bloc.dart' as _i20;
import '../viewmodel/user_leaves_bloc.dart' as _i21;
import 'AppModule.dart' as _i22; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i11.EmployeeDetailBloc>(
      _i11.EmployeeDetailBloc(get<_i4.EmployeeService>()));
  gh.singleton<_i12.EmployeeListBloc>(
      _i12.EmployeeListBloc(get<_i4.EmployeeService>()));
  gh.singleton<_i13.LoginBloc>(_i13.LoginBloc(get<_i9.AuthManager>()));
  gh.singleton<_i14.TeamLeavesApiService>(
      _i14.TeamLeavesApiService(get<_i10.Dio>(), get<_i7.UserPreference>()));
  gh.singleton<_i15.UserLeavesApiService>(
      _i15.UserLeavesApiService(get<_i10.Dio>(), get<_i7.UserPreference>()));
  gh.singleton<_i16.UserManager>(_i16.UserManager(get<_i7.UserPreference>()));
  gh.singleton<_i17.ApplyForLeaveApiService>(
      _i17.ApplyForLeaveApiService(get<_i10.Dio>(), get<_i7.UserPreference>()));
  gh.singleton<_i18.LoginState>(_i18.LoginState(get<_i16.UserManager>()));
  gh.factory<_i19.NetworkRepository>(() => _i19.NetworkRepository(
      get<_i15.UserLeavesApiService>(), get<_i14.TeamLeavesApiService>()));
  gh.singleton<_i20.TeamLeavesBloc>(
      _i20.TeamLeavesBloc(get<_i19.NetworkRepository>()));
  gh.singleton<_i21.UserLeavesBloc>(
      _i21.UserLeavesBloc(get<_i19.NetworkRepository>()));
  return get;
}

class _$AppModule extends _i22.AppModule {}
