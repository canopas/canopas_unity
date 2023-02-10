// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

import '../bloc/authentication/logout_bloc.dart' as _i38;
import '../bloc/network/network_connection_bloc.dart' as _i11;
import '../pref/user_preference.dart' as _i16;
import '../provider/user_data.dart' as _i29;
import '../router/app_router.dart' as _i32;
import '../services/admin/employee_service.dart' as _i7;
import '../services/admin/leave_service.dart' as _i3;
import '../services/admin/paid_leave_service.dart' as _i12;
import '../services/auth/auth_service.dart' as _i25;
import '../services/user/user_leave_service.dart' as _i15;
import '../stateManager/auth/auth_manager.dart' as _i34;
import '../stateManager/auth/desktop/desktop_auth_manager.dart' as _i6;
import '../ui/admin/addmember/bloc/add_member_bloc.dart' as _i18;
import '../ui/admin/admin_employees/bloc/admin_employees_bloc.dart' as _i20;
import '../ui/admin/edit_employe_details/bloc/admin_edit_employee_details_bloc.dart'
    as _i19;
import '../ui/admin/employee/detail/bloc/employee_detail_bloc.dart' as _i35;
import '../ui/admin/employee/list/bloc/employee_list_bloc.dart' as _i26;
import '../ui/admin/home/home_screen/bloc/admin_home_bloc.dart' as _i21;
import '../ui/admin/leave_request_details/bloc/admin_leave_details_bloc.dart'
    as _i22;
import '../ui/admin/leaves/bloc%20/admin_leaves_bloc.dart' as _i23;
import '../ui/admin/setting/bloc/admin_settings_bloc.dart' as _i31;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i24;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i4;
import '../ui/login/bloc/login_view_bloc.dart' as _i39;
import '../ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i9;
import '../ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i8;
import '../ui/shared/leave_details/bloc/leave_details_bloc/employee_leave_details_bloc.dart'
    as _i37;
import '../ui/user/employees/bloc/user_employees_bloc.dart' as _i14;
import '../ui/user/home/home_screen/bloc/user_home_bloc.dart' as _i40;
import '../ui/user/home/leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i10;
import '../ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i27;
import '../ui/user/leaves/applyLeave/bloc/leave_request_form_bloc/apply_leave_bloc.dart'
    as _i33;
import '../ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart' as _i28;
import '../ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i42;
import '../ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i41;
import '../ui/user/settings/edit_profile/bloc/edit_employee_details_employee_bloc.dart'
    as _i36;
import '../ui/user/settings/settings_screen/bloc/user_settings_bloc.dart'
    as _i30;
import '../widget/WhoIsOutCard/bloc/who_is_out_card_bloc.dart' as _i17;
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
  gh.factory<_i8.EmployeesCalendarLeavesBloc>(
      () => _i8.EmployeesCalendarLeavesBloc(
            get<_i7.EmployeeService>(),
            get<_i3.AdminLeaveService>(),
          ));
  gh.factory<_i9.EmployeesCalenderBloc>(() => _i9.EmployeesCalenderBloc());
  gh.factory<_i10.LeaveCalendarBloc>(() => _i10.LeaveCalendarBloc());
  gh.factory<_i11.NetworkConnectionBloc>(
      () => _i11.NetworkConnectionBloc(get<_i5.Connectivity>()));
  gh.singleton<_i12.PaidLeaveService>(_i12.PaidLeaveService());
  await gh.factoryAsync<_i13.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.factory<_i14.UserEmployeesBloc>(
      () => _i14.UserEmployeesBloc(get<_i7.EmployeeService>()));
  gh.singleton<_i15.UserLeaveService>(_i15.UserLeaveService());
  gh.singleton<_i16.UserPreference>(
      _i16.UserPreference(get<_i13.SharedPreferences>()));
  gh.factory<_i17.WhoIsOutCardBloc>(() => _i17.WhoIsOutCardBloc(
        get<_i7.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
      ));
  gh.factory<_i18.AddMemberBloc>(
      () => _i18.AddMemberBloc(get<_i7.EmployeeService>()));
  gh.factory<_i19.AdminEditEmployeeDetailsBloc>(
      () => _i19.AdminEditEmployeeDetailsBloc(get<_i7.EmployeeService>()));
  gh.factory<_i20.AdminEmployeesBloc>(
      () => _i20.AdminEmployeesBloc(get<_i7.EmployeeService>()));
  gh.factory<_i21.AdminHomeBloc>(() => _i21.AdminHomeBloc(
        get<_i3.AdminLeaveService>(),
        get<_i7.EmployeeService>(),
        get<_i15.UserLeaveService>(),
        get<_i12.PaidLeaveService>(),
      ));
  gh.factory<_i22.AdminLeaveApplicationDetailsBloc>(
      () => _i22.AdminLeaveApplicationDetailsBloc(
            get<_i15.UserLeaveService>(),
            get<_i3.AdminLeaveService>(),
            get<_i12.PaidLeaveService>(),
          ));
  gh.factory<_i23.AdminLeavesBloc>(() => _i23.AdminLeavesBloc(
        get<_i3.AdminLeaveService>(),
        get<_i7.EmployeeService>(),
      ));
  gh.factory<_i24.AdminSettingUpdatePaidLeaveCountBloc>(() =>
      _i24.AdminSettingUpdatePaidLeaveCountBloc(get<_i12.PaidLeaveService>()));
  gh.singleton<_i25.AuthService>(_i25.AuthService(
    get<_i6.DesktopAuthManager>(),
    get<_i16.UserPreference>(),
  ));
  gh.factory<_i26.EmployeeListBloc>(
      () => _i26.EmployeeListBloc(get<_i7.EmployeeService>()));
  gh.factory<_i27.UserLeaveCalendarBloc>(() => _i27.UserLeaveCalendarBloc(
        get<_i15.UserLeaveService>(),
        get<_i7.EmployeeService>(),
        get<_i12.PaidLeaveService>(),
      ));
  gh.factory<_i28.UserLeaveDetailBloc>(
      () => _i28.UserLeaveDetailBloc(get<_i15.UserLeaveService>()));
  gh.singleton<_i29.UserManager>(_i29.UserManager(get<_i16.UserPreference>()));
  gh.factory<_i30.UserSettingsBloc>(() => _i30.UserSettingsBloc(
        get<_i29.UserManager>(),
        get<_i25.AuthService>(),
        get<_i16.UserPreference>(),
      ));
  gh.factory<_i31.AdminSettingsBloc>(() => _i31.AdminSettingsBloc(
        get<_i29.UserManager>(),
        get<_i25.AuthService>(),
        get<_i16.UserPreference>(),
      ));
  gh.factory<_i32.AppRouter>(() => _i32.AppRouter(get<_i29.UserManager>()));
  gh.factory<_i33.ApplyLeaveBloc>(() => _i33.ApplyLeaveBloc(
        get<_i29.UserManager>(),
        get<_i12.PaidLeaveService>(),
        get<_i15.UserLeaveService>(),
      ));
  gh.singleton<_i34.AuthManager>(_i34.AuthManager(
    get<_i16.UserPreference>(),
    get<_i25.AuthService>(),
  ));
  gh.factory<_i35.EmployeeDetailBloc>(() => _i35.EmployeeDetailBloc(
        get<_i7.EmployeeService>(),
        get<_i15.UserLeaveService>(),
        get<_i29.UserManager>(),
      ));
  gh.factory<_i36.EmployeeEditEmployeeDetailsBloc>(
      () => _i36.EmployeeEditEmployeeDetailsBloc(
            get<_i7.EmployeeService>(),
            get<_i16.UserPreference>(),
            get<_i29.UserManager>(),
          ));
  gh.factory<_i37.LeaveDetailsBloc>(() => _i37.LeaveDetailsBloc(
        get<_i15.UserLeaveService>(),
        get<_i12.PaidLeaveService>(),
        get<_i29.UserManager>(),
      ));
  gh.factory<_i38.LogOutBloc>(() => _i38.LogOutBloc(
        get<_i16.UserPreference>(),
        get<_i25.AuthService>(),
        get<_i29.UserManager>(),
      ));
  gh.factory<_i39.LoginBloc>(() => _i39.LoginBloc(
        get<_i34.AuthManager>(),
        get<_i29.UserManager>(),
        get<_i25.AuthService>(),
      ));
  gh.factory<_i40.UserHomeBloc>(() => _i40.UserHomeBloc(
        get<_i16.UserPreference>(),
        get<_i25.AuthService>(),
        get<_i29.UserManager>(),
      ));
  gh.factory<_i41.UserLeaveBloc>(() => _i41.UserLeaveBloc(
        get<_i29.UserManager>(),
        get<_i15.UserLeaveService>(),
      ));
  gh.factory<_i42.UserLeaveCountBloc>(() => _i42.UserLeaveCountBloc(
        get<_i15.UserLeaveService>(),
        get<_i29.UserManager>(),
        get<_i12.PaidLeaveService>(),
      ));
  return get;
}

class _$AppModule extends _i43.AppModule {}
