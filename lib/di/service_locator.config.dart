// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../navigation/login_state.dart' as _i17;
import '../navigation/navigation_stack_manager.dart' as _i18;
import '../rest/api_interceptor.dart' as _i7;
import '../services/auth_manager.dart' as _i8;
import '../services/auth_service.dart' as _i3;
import '../services/employee_service.dart' as _i4;
import '../services/leave/apply_for_leaves_api_service.dart' as _i16;
import '../services/leave/team_leaves_api_service.dart' as _i13;
import '../services/leave/user_leaves_api_service.dart' as _i14;
import '../services/network_repository.dart' as _i19;
import '../user/user_manager.dart' as _i15;
import '../user/user_preference.dart' as _i6;
import '../viewmodel/employee_detail_bloc.dart' as _i10;
import '../viewmodel/employee_list_bloc.dart' as _i11;
import '../viewmodel/login_bloc.dart' as _i12;
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
  await gh.factoryAsync<_i5.SharedPreferences>(() => appModule.preferences,
      preResolve: true);
  gh.factory<_i6.UserPreference>(
      () => _i6.UserPreference(get<_i5.SharedPreferences>()));
  gh.singleton<_i7.ApiInterceptor>(
      _i7.ApiInterceptor(get<_i6.UserPreference>()));
  gh.singleton<_i8.AuthManager>(
      _i8.AuthManager(get<_i6.UserPreference>(), get<_i3.AuthService>()));
  gh.singleton<_i9.Dio>(appModule.dio(get<_i7.ApiInterceptor>()));
  gh.singleton<_i10.EmployeeDetailBloc>(
      _i10.EmployeeDetailBloc(get<_i4.EmployeeService>()));
  gh.singleton<_i11.EmployeeListBloc>(
      _i11.EmployeeListBloc(get<_i4.EmployeeService>()));
  gh.singleton<_i12.LoginBloc>(_i12.LoginBloc(get<_i8.AuthManager>()));
  gh.singleton<_i13.TeamLeavesApiService>(
      _i13.TeamLeavesApiService(get<_i9.Dio>(), get<_i6.UserPreference>()));
  gh.singleton<_i14.UserLeavesApiService>(
      _i14.UserLeavesApiService(get<_i9.Dio>(), get<_i6.UserPreference>()));
  gh.singleton<_i15.UserManager>(_i15.UserManager(get<_i6.UserPreference>()));
  gh.singleton<_i16.ApplyForLeaveApiService>(
      _i16.ApplyForLeaveApiService(get<_i9.Dio>(), get<_i6.UserPreference>()));
  gh.singleton<_i17.LoginState>(_i17.LoginState(get<_i15.UserManager>()));
  gh.singleton<_i18.NavigationStackManager>(
      _i18.NavigationStackManager(get<_i15.UserManager>()));
  gh.factory<_i19.NetworkRepository>(() => _i19.NetworkRepository(
      get<_i14.UserLeavesApiService>(), get<_i13.TeamLeavesApiService>()));
  gh.singleton<_i20.TeamLeavesBloc>(
      _i20.TeamLeavesBloc(get<_i19.NetworkRepository>()));
  gh.singleton<_i21.UserLeavesBloc>(
      _i21.UserLeavesBloc(get<_i19.NetworkRepository>()));
  return get;
}

class _$AppModule extends _i22.AppModule {}
