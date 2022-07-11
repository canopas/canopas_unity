// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../bloc/employee_detail_bloc.dart' as _i13;
import '../bloc/employee_list_bloc.dart' as _i14;
import '../bloc/employee_validation.dart' as _i6;
import '../bloc/leaves/user_all_leaves_bloc.dart' as _i16;
import '../bloc/login_bloc.dart' as _i15;
import '../navigation/navigation_stack_manager.dart' as _i19;
import '../rest/api_interceptor.dart' as _i10;
import '../services/auth_manager.dart' as _i11;
import '../services/auth_service.dart' as _i4;
import '../services/employee/employee_service.dart' as _i5;
import '../services/leave/user_leave_service.dart' as _i8;
import '../stateManager/apply_leave_state_provider.dart' as _i3;
import '../stateManager/login_state.dart' as _i18;
import '../user/user_manager.dart' as _i17;
import '../user/user_preference.dart' as _i9;
import 'AppModule.dart' as _i20; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.singleton<_i3.ApplyLeaveStateProvider>(_i3.ApplyLeaveStateProvider());
  gh.singleton<_i4.AuthService>(_i4.AuthService());
  gh.singleton<_i5.EmployeeService>(_i5.EmployeeService());
  gh.singleton<_i6.EmployeeValidationBloc>(_i6.EmployeeValidationBloc());
  await gh.factoryAsync<_i7.SharedPreferences>(() => appModule.preferences,
      preResolve: true);
  gh.singleton<_i8.UserLeaveService>(_i8.UserLeaveService());
  gh.factory<_i9.UserPreference>(
      () => _i9.UserPreference(get<_i7.SharedPreferences>()));
  gh.singleton<_i10.ApiInterceptor>(
      _i10.ApiInterceptor(get<_i9.UserPreference>()));
  gh.singleton<_i11.AuthManager>(
      _i11.AuthManager(get<_i9.UserPreference>(), get<_i4.AuthService>()));
  gh.singleton<_i12.Dio>(appModule.dio(get<_i10.ApiInterceptor>()));
  gh.singleton<_i13.EmployeeDetailBloc>(
      _i13.EmployeeDetailBloc(get<_i5.EmployeeService>()));
  gh.singleton<_i14.EmployeeListBloc>(
      _i14.EmployeeListBloc(get<_i5.EmployeeService>()));
  gh.singleton<_i15.LoginBloc>(_i15.LoginBloc(get<_i11.AuthManager>()));
  gh.singleton<_i16.UserAllLeavesBloc>(
      _i16.UserAllLeavesBloc(get<_i8.UserLeaveService>()));
  gh.singleton<_i17.UserManager>(_i17.UserManager(get<_i9.UserPreference>()));
  gh.singleton<_i18.LoginState>(_i18.LoginState(get<_i17.UserManager>()));
  gh.singleton<_i19.NavigationStackManager>(
      _i19.NavigationStackManager(get<_i17.UserManager>()));
  return get;
}

class _$AppModule extends _i20.AppModule {}
