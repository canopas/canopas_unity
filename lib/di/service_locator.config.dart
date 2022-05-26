// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../Navigation/login_state.dart' as _i16;
import '../Navigation/navigation_stack_manager.dart' as _i6;
import '../ViewModel/employee_detail_bloc.dart' as _i20;
import '../ViewModel/employee_list_bloc.dart' as _i21;
import '../ViewModel/login_bloc.dart' as _i22;
import '../ViewModel/team_leaves_bloc.dart' as _i18;
import '../ViewModel/user_leaves_bloc.dart' as _i19;
import '../services/EmployeeApiService/employee_detail_api_service.dart'
    as _i10;
import '../services/EmployeeApiService/employee_list_api_service.dart' as _i11;
import '../services/LeaveService/apply_for_leaves_api_service.dart' as _i9;
import '../services/LeaveService/team_leaves_api_service.dart' as _i13;
import '../services/LeaveService/user_leaves_api_service.dart' as _i14;
import '../services/login/login_api_service.dart' as _i12;
import '../services/login/login_request_provider.dart' as _i4;
import '../services/login/login_service.dart' as _i5;
import '../services/network_repository.dart' as _i17;
import '../user/user_manager.dart' as _i15;
import '../user/user_preference.dart' as _i8;
import 'AppModule.dart' as _i23; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i6.NavigationStackManager>(_i6.NavigationStackManager());
  await gh.factoryAsync<_i7.SharedPreferences>(() => appModule.preferences,
      preResolve: true);
  gh.factory<_i8.UserPreference>(
      () => _i8.UserPreference(get<_i7.SharedPreferences>()));
  gh.singleton<_i9.ApplyForLeaveApiService>(
      _i9.ApplyForLeaveApiService(get<_i3.Dio>(), get<_i8.UserPreference>()));
  gh.factory<_i10.EmployeeDetailApiService>(() =>
      _i10.EmployeeDetailApiService(get<_i3.Dio>(), get<_i8.UserPreference>()));
  gh.factory<_i11.EmployeeListApiService>(() =>
      _i11.EmployeeListApiService(get<_i3.Dio>(), get<_i8.UserPreference>()));
  gh.factory<_i12.LoginApiService>(() => _i12.LoginApiService(
      get<_i8.UserPreference>(), get<_i3.Dio>(), get<_i5.LoginService>()));
  gh.singleton<_i13.TeamLeavesApiService>(
      _i13.TeamLeavesApiService(get<_i3.Dio>(), get<_i8.UserPreference>()));
  gh.singleton<_i14.UserLeavesApiService>(
      _i14.UserLeavesApiService(get<_i3.Dio>(), get<_i8.UserPreference>()));
  gh.singleton<_i15.UserManager>(_i15.UserManager(get<_i8.UserPreference>()));
  gh.singleton<_i16.LoginState>(_i16.LoginState(get<_i15.UserManager>()));
  gh.factory<_i17.NetworkRepository>(() => _i17.NetworkRepository(
      get<_i12.LoginApiService>(),
      get<_i11.EmployeeListApiService>(),
      get<_i10.EmployeeDetailApiService>(),
      get<_i14.UserLeavesApiService>(),
      get<_i13.TeamLeavesApiService>()));
  gh.singleton<_i18.TeamLeavesBloc>(
      _i18.TeamLeavesBloc(get<_i17.NetworkRepository>()));
  gh.singleton<_i19.UserLeavesBloc>(
      _i19.UserLeavesBloc(get<_i17.NetworkRepository>()));
  gh.singleton<_i20.EmployeeDetailBloc>(
      _i20.EmployeeDetailBloc(get<_i17.NetworkRepository>()));
  gh.singleton<_i21.EmployeeListBloc>(
      _i21.EmployeeListBloc(get<_i17.NetworkRepository>()));
  gh.singleton<_i22.LoginBloc>(_i22.LoginBloc(get<_i17.NetworkRepository>()));
  return get;
}

class _$AppModule extends _i23.AppModule {}
