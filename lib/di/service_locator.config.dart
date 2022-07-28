// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../bloc/admin/employee/employee_detail_bloc.dart' as _i13;
import '../bloc/admin/employee/employee_list_bloc.dart' as _i15;
import '../bloc/admin/employee/employee_validation.dart' as _i7;
import '../bloc/admin/leave/employee_leave_bloc.dart' as _i14;
import '../bloc/leaves/user/leaves/all_leaves_bloc.dart' as _i20;
import '../bloc/login/login_bloc.dart' as _i16;
import '../navigation/navigation_stack_manager.dart' as _i19;
import '../pref/user_preference.dart' as _i11;
import '../provider/user_data.dart' as _i17;
import '../services/auth/auth_service.dart' as _i5;
import '../services/employee/employee_service.dart' as _i6;
import '../services/leave/admin_leave_service.dart' as _i3;
import '../services/leave/user_leave_service.dart' as _i10;
import '../stateManager/admin/leave_status_manager.dart' as _i9;
import '../stateManager/auth/auth_manager.dart' as _i12;
import '../stateManager/login_state_manager.dart' as _i18;
import '../stateManager/user/leave_request_data_manager.dart' as _i4;
import 'AppModule.dart' as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.AdminLeaveService>(() => _i3.AdminLeaveService());
  gh.singleton<_i4.LeaveRequestDataManager>(_i4.LeaveRequestDataManager());
  gh.singleton<_i5.AuthService>(_i5.AuthService());
  gh.singleton<_i6.EmployeeService>(_i6.EmployeeService());
  gh.singleton<_i7.EmployeeValidationBloc>(_i7.EmployeeValidationBloc());
  await gh.factoryAsync<_i8.SharedPreferences>(() => appModule.preferences,
      preResolve: true);
  gh.singleton<_i9.LeaveStatusManager>(
      _i9.LeaveStatusManager(get<_i3.AdminLeaveService>()));
  gh.singleton<_i10.UserLeaveService>(_i10.UserLeaveService());
  gh.factory<_i11.UserPreference>(
      () => _i11.UserPreference(get<_i8.SharedPreferences>()));
  gh.singleton<_i12.AuthManager>(
      _i12.AuthManager(get<_i11.UserPreference>(), get<_i5.AuthService>()));
  gh.singleton<_i13.EmployeeDetailBloc>(
      _i13.EmployeeDetailBloc(get<_i6.EmployeeService>()));
  gh.singleton<_i14.EmployeeLeaveBloc>(_i14.EmployeeLeaveBloc(
      get<_i6.EmployeeService>(), get<_i10.UserLeaveService>()));
  gh.singleton<_i15.EmployeeListBloc>(
      _i15.EmployeeListBloc(get<_i6.EmployeeService>()));
  gh.singleton<_i16.LoginBloc>(_i16.LoginBloc(get<_i12.AuthManager>()));
  gh.singleton<_i17.UserManager>(_i17.UserManager(get<_i11.UserPreference>()));
  gh.singleton<_i18.LoginState>(_i18.LoginState(get<_i17.UserManager>()));
  gh.singleton<_i19.NavigationStackManager>(
      _i19.NavigationStackManager(get<_i17.UserManager>()));
  gh.singleton<_i20.UserAllLeavesBloc>(_i20.UserAllLeavesBloc(
      get<_i10.UserLeaveService>(), get<_i17.UserManager>()));
  return get;
}

class _$AppModule extends _i21.AppModule {}
