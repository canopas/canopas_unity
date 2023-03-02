// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import '../bloc/authentication/logout_bloc.dart' as _i37;
import '../bloc/network/network_connection_bloc.dart' as _i10;
import '../pref/user_preference.dart' as _i14;
import '../provider/user_data.dart' as _i28;
import '../router/app_router.dart' as _i31;
import '../services/admin/employee_service.dart' as _i7;
import '../services/admin/leave_service.dart' as _i3;
import '../services/admin/paid_leave_service.dart' as _i11;
import '../services/auth/auth_service.dart' as _i23;
import '../services/user/user_leave_service.dart' as _i13;
import '../stateManager/auth/auth_manager.dart' as _i33;
import '../stateManager/auth/desktop/desktop_auth_manager.dart' as _i6;
import '../ui/admin/employee/detail/bloc/employee_detail_bloc.dart' as _i34;
import '../ui/admin/employee/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i17;
import '../ui/admin/employee/list/bloc/employee_list_bloc.dart' as _i24;
import '../ui/admin/home/addmember/bloc/add_member_bloc.dart' as _i16;
import '../ui/admin/home/application_detail/bloc/admin_leave_application_detail_bloc.dart'
    as _i19;
import '../ui/admin/home/home_screen/bloc/admin_home_bloc.dart' as _i18;
import '../ui/admin/leaves/detail/bloc/admin_leave_detail_bloc.dart' as _i20;
import '../ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart' as _i21;
import '../ui/admin/setting/bloc/admin_settings_bloc.dart' as _i30;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i22;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i4;
import '../ui/login/bloc/login_view_bloc.dart' as _i38;
import '../ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i8;
import '../ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i36;
import '../ui/user/employees/detail/bloc/user_employee_detail_bloc.dart'
    as _i25;
import '../ui/user/employees/list/bloc/user_employees_bloc.dart' as _i39;
import '../ui/user/home/home_screen/bloc/user_home_bloc.dart' as _i40;
import '../ui/user/home/leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i9;
import '../ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i26;
import '../ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart' as _i32;
import '../ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart' as _i27;
import '../ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i42;
import '../ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i41;
import '../ui/user/settings/edit_profile/bloc/emloyee_edit_profile_bloc.dart'
    as _i35;
import '../ui/user/settings/settings_screen/bloc/user_settings_bloc.dart'
    as _i29;
import '../widget/WhoIsOutCard/bloc/who_is_out_card_bloc.dart' as _i15;
import 'app_module.dart' as _i43; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.singleton<_i3.AdminLeaveService>(
    _i3.AdminLeaveService(),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i4.AdminPaidLeaveUpdateSettingTextFieldBloc>(
      () => _i4.AdminPaidLeaveUpdateSettingTextFieldBloc());
  gh.factory<_i5.Connectivity>(() => appModule.connectivity);
  gh.factory<_i6.DesktopAuthManager>(() => _i6.DesktopAuthManager());
  gh.singleton<_i7.EmployeeService>(
    _i7.EmployeeService(),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i8.EmployeesCalenderBloc>(() => _i8.EmployeesCalenderBloc());
  gh.factory<_i9.LeaveCalendarBloc>(() => _i9.LeaveCalendarBloc());
  gh.factory<_i10.NetworkConnectionBloc>(
      () => _i10.NetworkConnectionBloc(get<_i5.Connectivity>()));
  gh.singleton<_i11.PaidLeaveService>(_i11.PaidLeaveService());
  await gh.factoryAsync<_i12.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.singleton<_i13.UserLeaveService>(_i13.UserLeaveService());
  gh.singleton<_i14.UserPreference>(
      _i14.UserPreference(get<_i12.SharedPreferences>()));
  gh.factory<_i15.WhoIsOutCardBloc>(() => _i15.WhoIsOutCardBloc(
        get<_i7.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
      ));
  gh.factory<_i16.AddMemberBloc>(
      () => _i16.AddMemberBloc(get<_i7.EmployeeService>()));
  gh.factory<_i17.AdminEditEmployeeDetailsBloc>(
      () => _i17.AdminEditEmployeeDetailsBloc(get<_i7.EmployeeService>()));
  gh.factory<_i18.AdminHomeBloc>(() => _i18.AdminHomeBloc(
        get<_i3.AdminLeaveService>(),
        get<_i7.EmployeeService>(),
      ));
  gh.factory<_i19.AdminLeaveApplicationDetailsBloc>(
      () => _i19.AdminLeaveApplicationDetailsBloc(
            get<_i13.UserLeaveService>(),
            get<_i3.AdminLeaveService>(),
            get<_i11.PaidLeaveService>(),
          ));
  gh.factory<_i20.AdminLeaveDetailBloc>(() => _i20.AdminLeaveDetailBloc(
        get<_i13.UserLeaveService>(),
        get<_i11.PaidLeaveService>(),
      ));
  gh.factory<_i21.AdminLeavesBloc>(() => _i21.AdminLeavesBloc(
        get<_i3.AdminLeaveService>(),
        get<_i7.EmployeeService>(),
      ));
  gh.factory<_i22.AdminSettingUpdatePaidLeaveCountBloc>(() =>
      _i22.AdminSettingUpdatePaidLeaveCountBloc(get<_i11.PaidLeaveService>()));
  gh.singleton<_i23.AuthService>(_i23.AuthService(
    get<_i6.DesktopAuthManager>(),
    get<_i14.UserPreference>(),
  ));
  gh.factory<_i24.EmployeeListBloc>(
      () => _i24.EmployeeListBloc(get<_i7.EmployeeService>()));
  gh.factory<_i25.UserEmployeeDetailBloc>(() => _i25.UserEmployeeDetailBloc(
        get<_i7.EmployeeService>(),
        get<_i13.UserLeaveService>(),
      ));
  gh.factory<_i26.UserLeaveCalendarBloc>(() => _i26.UserLeaveCalendarBloc(
        get<_i13.UserLeaveService>(),
        get<_i7.EmployeeService>(),
        get<_i11.PaidLeaveService>(),
      ));
  gh.factory<_i27.UserLeaveDetailBloc>(
      () => _i27.UserLeaveDetailBloc(get<_i13.UserLeaveService>()));
  gh.singleton<_i28.UserManager>(_i28.UserManager(get<_i14.UserPreference>()));
  gh.factory<_i29.UserSettingsBloc>(() => _i29.UserSettingsBloc(
        get<_i28.UserManager>(),
        get<_i23.AuthService>(),
        get<_i14.UserPreference>(),
      ));
  gh.factory<_i30.AdminSettingsBloc>(() => _i30.AdminSettingsBloc(
        get<_i28.UserManager>(),
        get<_i23.AuthService>(),
        get<_i14.UserPreference>(),
      ));
  gh.factory<_i31.AppRouter>(() => _i31.AppRouter(get<_i28.UserManager>()));
  gh.factory<_i32.ApplyLeaveBloc>(() => _i32.ApplyLeaveBloc(
        get<_i28.UserManager>(),
        get<_i11.PaidLeaveService>(),
        get<_i13.UserLeaveService>(),
      ));
  gh.singleton<_i33.AuthManager>(_i33.AuthManager(
    get<_i14.UserPreference>(),
    get<_i23.AuthService>(),
  ));
  gh.factory<_i34.EmployeeDetailBloc>(() => _i34.EmployeeDetailBloc(
        get<_i11.PaidLeaveService>(),
        get<_i7.EmployeeService>(),
        get<_i13.UserLeaveService>(),
        get<_i28.UserManager>(),
      ));
  gh.factory<_i35.EmployeeEditProfileBloc>(() => _i35.EmployeeEditProfileBloc(
        get<_i7.EmployeeService>(),
        get<_i14.UserPreference>(),
        get<_i28.UserManager>(),
      ));
  gh.factory<_i36.EmployeesCalendarLeavesBloc>(
      () => _i36.EmployeesCalendarLeavesBloc(
            get<_i7.EmployeeService>(),
            get<_i3.AdminLeaveService>(),
            get<_i28.UserManager>(),
          ));
  gh.factory<_i37.LogOutBloc>(() => _i37.LogOutBloc(
        get<_i14.UserPreference>(),
        get<_i23.AuthService>(),
        get<_i28.UserManager>(),
      ));
  gh.factory<_i38.LoginBloc>(() => _i38.LoginBloc(
        get<_i33.AuthManager>(),
        get<_i28.UserManager>(),
        get<_i23.AuthService>(),
      ));
  gh.factory<_i39.UserEmployeesBloc>(() => _i39.UserEmployeesBloc(
        get<_i7.EmployeeService>(),
        get<_i28.UserManager>(),
      ));
  gh.factory<_i40.UserHomeBloc>(() => _i40.UserHomeBloc(
        get<_i14.UserPreference>(),
        get<_i23.AuthService>(),
        get<_i28.UserManager>(),
        get<_i13.UserLeaveService>(),
      ));
  gh.factory<_i41.UserLeaveBloc>(() => _i41.UserLeaveBloc(
        get<_i28.UserManager>(),
        get<_i13.UserLeaveService>(),
      ));
  gh.factory<_i42.UserLeaveCountBloc>(() => _i42.UserLeaveCountBloc(
        get<_i13.UserLeaveService>(),
        get<_i28.UserManager>(),
        get<_i11.PaidLeaveService>(),
      ));
  return get;
}

class _$AppModule extends _i43.AppModule {}
