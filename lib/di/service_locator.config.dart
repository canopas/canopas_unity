// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/bloc/user/setting_view_bloc.dart' as _i24;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../bloc/admin/employee/employee_detail_bloc.dart' as _i14;
import '../bloc/admin/employee/employee_list_bloc.dart' as _i15;
import '../bloc/admin/employee/employee_validation.dart' as _i6;
import '../bloc/admin/employees_summary/employees_summary_bloc.dart' as _i28;
import '../bloc/admin/leave/leave_application_bloc.dart' as _i7;
import '../bloc/admin/leave_count/all_leave_count.dart' as _i26;
import '../bloc/employee/employee_leave_count/employee_leave_count_bloc.dart' as _i25;
import '../bloc/leaves/user/leaves/all_leaves_bloc.dart' as _i22;
import '../bloc/leaves/user/leaves/requested_leave_bloc.dart' as _i18;
import '../bloc/leaves/user/leaves/upcoming_leave_bloc.dart' as _i21;
import '../bloc/login/login_bloc.dart' as _i16;
import '../navigation/navigation_stack_manager.dart' as _i20;
import '../pref/user_preference.dart' as _i12;
import '../provider/user_data.dart' as _i17;
import '../services/auth/auth_service.dart' as _i4;
import '../services/employee/employee_service.dart' as _i5;
import '../services/leave/admin_leave_service.dart' as _i3;
import '../services/leave/user_leave_service.dart' as _i11;
import '../stateManager/admin/leave_status_manager.dart' as _i9;
import '../stateManager/auth/auth_manager.dart' as _i13;
import '../stateManager/login_state_manager.dart' as _i19;
import '../stateManager/user/leave_request_data_manager.dart' as _i8;
import 'AppModule.dart' as _i23; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.AdminLeaveService>(() => _i3.AdminLeaveService());
  gh.singleton<_i4.AuthService>(_i4.AuthService());
  gh.singleton<_i5.EmployeeService>(_i5.EmployeeService());
  gh.singleton<_i6.EmployeeValidationBloc>(_i6.EmployeeValidationBloc());
  gh.singleton<_i7.LeaveApplicationBloc>(_i7.LeaveApplicationBloc(
      get<_i5.EmployeeService>(), get<_i3.AdminLeaveService>()));
  gh.singleton<_i8.LeaveRequestDataManager>(_i8.LeaveRequestDataManager());
  gh.singleton<_i9.LeaveStatusManager>(
      _i9.LeaveStatusManager(get<_i3.AdminLeaveService>()));
  await gh.factoryAsync<_i10.SharedPreferences>(() => appModule.preferences,
      preResolve: true);
  gh.singleton<_i11.UserLeaveService>(_i11.UserLeaveService());
  gh.factory<_i12.UserPreference>(
      () => _i12.UserPreference(get<_i10.SharedPreferences>()));
  gh.singleton<_i13.AuthManager>(
      _i13.AuthManager(get<_i12.UserPreference>(), get<_i4.AuthService>()));
  gh.singleton<_i14.EmployeeDetailBloc>(
      _i14.EmployeeDetailBloc(get<_i5.EmployeeService>()));
  gh.singleton<_i15.EmployeeListBloc>(
      _i15.EmployeeListBloc(get<_i5.EmployeeService>()));
  gh.singleton<_i16.LoginBloc>(_i16.LoginBloc(get<_i13.AuthManager>()));
  gh.singleton<_i17.UserManager>(_i17.UserManager(get<_i12.UserPreference>()));
  gh.singleton<_i18.UserRequestedLeaveBloc>(_i18.UserRequestedLeaveBloc(
      get<_i17.UserManager>(), get<_i11.UserLeaveService>()));
  gh.singleton<_i19.LoginState>(_i19.LoginState(get<_i17.UserManager>()));
  gh.singleton<_i20.NavigationStackManager>(
      _i20.NavigationStackManager(get<_i17.UserManager>()));
  gh.singleton<_i21.UpcomingLeaveBloc>(_i21.UpcomingLeaveBloc(
      get<_i17.UserManager>(), get<_i11.UserLeaveService>()));
  gh.singleton<_i22.UserAllLeavesBloc>(_i22.UserAllLeavesBloc(
      get<_i11.UserLeaveService>(), get<_i17.UserManager>()));
  gh.singleton<_i24.SettingViewBLoc>(_i24.SettingViewBLoc());
  gh.singleton<_i25.EmployeeLeaveCountBlock>(_i25.EmployeeLeaveCountBlock(
    get<_i17.UserManager>(),get<_i11.UserLeaveService>()));
  gh.singleton<_i26.AdminLeaveCount>(_i26.AdminLeaveCount());
  gh.singleton<_i28.EmployeesSummaryBloc>(_i28.EmployeesSummaryBloc(
      _i3.AdminLeaveService(),_i5.EmployeeService()));
  return get;
}

class _$AppModule extends _i23.AppModule {}
