// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i14;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../bloc/employee_detail_bloc.dart' as _i15;
import '../bloc/employee_leave_bloc.dart' as _i16;
import '../bloc/employee_list_bloc.dart' as _i17;
import '../bloc/employee_validation.dart' as _i7;
import '../bloc/leaves/user_all_leaves_bloc.dart' as _i19;
import '../bloc/login_bloc.dart' as _i18;
import '../navigation/navigation_stack_manager.dart' as _i22;
import '../rest/api_interceptor.dart' as _i12;
import '../services/auth_manager.dart' as _i13;
import '../services/auth_service.dart' as _i5;
import '../services/employee/employee_service.dart' as _i6;
import '../services/leave/admin_leave_service.dart' as _i3;
import '../services/leave/user_leave_service.dart' as _i10;
import '../stateManager/admin/leave_status_update.dart' as _i9;
import '../stateManager/apply_leave_state_provider.dart' as _i4;
import '../stateManager/login_state.dart' as _i21;
import '../user/user_manager.dart' as _i20;
import '../user/user_preference.dart' as _i11;
import 'AppModule.dart' as _i23; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.AdminLeaveService>(() => _i3.AdminLeaveService());
  gh.singleton<_i4.ApplyLeaveStateProvider>(_i4.ApplyLeaveStateProvider());
  gh.singleton<_i5.AuthService>(_i5.AuthService());
  gh.singleton<_i6.EmployeeService>(_i6.EmployeeService());
  gh.singleton<_i7.EmployeeValidationBloc>(_i7.EmployeeValidationBloc());
  await gh.factoryAsync<_i8.SharedPreferences>(() => appModule.preferences,
      preResolve: true);
  gh.singleton<_i9.UpdateLeaveStatus>(
      _i9.UpdateLeaveStatus(get<_i3.AdminLeaveService>()));
  gh.singleton<_i10.UserLeaveService>(_i10.UserLeaveService());
  gh.factory<_i11.UserPreference>(
      () => _i11.UserPreference(get<_i8.SharedPreferences>()));
  gh.singleton<_i12.ApiInterceptor>(
      _i12.ApiInterceptor(get<_i11.UserPreference>()));
  gh.singleton<_i13.AuthManager>(
      _i13.AuthManager(get<_i11.UserPreference>(), get<_i5.AuthService>()));
  gh.singleton<_i14.Dio>(appModule.dio(get<_i12.ApiInterceptor>()));
  gh.singleton<_i15.EmployeeDetailBloc>(
      _i15.EmployeeDetailBloc(get<_i6.EmployeeService>()));
  gh.singleton<_i16.EmployeeLeaveBloc>(_i16.EmployeeLeaveBloc(
      get<_i6.EmployeeService>(), get<_i10.UserLeaveService>()));
  gh.singleton<_i17.EmployeeListBloc>(
      _i17.EmployeeListBloc(get<_i6.EmployeeService>()));
  gh.singleton<_i18.LoginBloc>(_i18.LoginBloc(get<_i13.AuthManager>()));
  gh.singleton<_i19.UserAllLeavesBloc>(
      _i19.UserAllLeavesBloc(get<_i10.UserLeaveService>()));
  gh.singleton<_i20.UserManager>(_i20.UserManager(get<_i11.UserPreference>()));
  gh.singleton<_i21.LoginState>(_i21.LoginState(get<_i20.UserManager>()));
  gh.singleton<_i22.NavigationStackManager>(
      _i22.NavigationStackManager(get<_i20.UserManager>()));
  return get;
}

class _$AppModule extends _i23.AppModule {}
