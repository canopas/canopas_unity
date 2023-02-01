// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i14;

import '../bloc/authentication/logout_bloc.dart' as _i37;
import '../bloc/network/network_connection_bloc.dart' as _i12;
import '../pref/user_preference.dart' as _i17;
import '../provider/user_data.dart' as _i27;
import '../router/app_router.dart' as _i31;
import '../services/admin/employee_service.dart' as _i8;
import '../services/admin/leave_service.dart' as _i3;
import '../services/admin/paid_leave_service.dart' as _i13;
import '../services/auth/auth_service.dart' as _i24;
import '../services/user/user_leave_service.dart' as _i16;
import '../stateManager/auth/auth_manager.dart' as _i33;
import '../stateManager/auth/desktop/desktop_auth_manager.dart' as _i7;
import '../ui/admin/addmember/bloc/add_member_bloc.dart' as _i19;
import '../ui/admin/edit_employe_details/bloc/admin_edit_employee_details_bloc.dart'
    as _i20;
import '../ui/admin/employee/detail/bloc/employee_detail_bloc.dart' as _i34;
import '../ui/admin/employee/list/bloc/employee_list_bloc.dart' as _i25;
import '../ui/admin/home/bloc/admin_home_bloc.dart' as _i21;
import '../ui/admin/leave_request_details/bloc/admin_leave_details_bloc.dart'
    as _i22;
import '../ui/admin/setting/bloc/admin_settings_bloc.dart' as _i29;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i23;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i4;
import '../ui/login/bloc/login_view_bloc.dart' as _i38;
import '../ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i10;
import '../ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i9;
import '../ui/shared/leave_details/bloc/leave_details_bloc/employee_leave_details_bloc.dart'
    as _i36;
import '../ui/user/all_leaves/bloc/filter_bloc/all_leaves_filter_bloc.dart'
    as _i5;
import '../ui/user/all_leaves/bloc/leaves_bloc/all_leaves_bloc.dart' as _i30;
import '../ui/user/edit_employee_details/bloc/edit_employee_details_employee_bloc.dart'
    as _i35;
import '../ui/user/leave/applyLeave/bloc/leave_request_form_bloc/apply_leave_bloc.dart'
    as _i32;
import '../ui/user/requested_leaves/bloc/requested_leaves_bloc.dart' as _i39;
import '../ui/user/upcoming_leaves/bloc/upcoming_leaves_bloc.dart' as _i40;
import '../ui/user/user_employees/bloc/user_employees_bloc.dart' as _i15;
import '../ui/user/user_home/bloc/user_home_bloc.dart' as _i41;
import '../ui/user/user_leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i11;
import '../ui/user/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i26;
import '../ui/user/user_settings/bloc/user_settings_bloc.dart' as _i28;
import '../widget/WhoIsOutCard/bloc/who_is_out_card_bloc.dart' as _i18;
import 'app_module.dart' as _i42; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i5.AllLeavesFilterBloc>(() => _i5.AllLeavesFilterBloc());
  gh.factory<_i6.Connectivity>(() => appModule.connectivity);
  gh.factory<_i7.DesktopAuthManager>(() => _i7.DesktopAuthManager());
  gh.singleton<_i8.EmployeeService>(
    _i8.EmployeeService(),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i9.EmployeesCalendarLeavesBloc>(
      () => _i9.EmployeesCalendarLeavesBloc(
            get<_i8.EmployeeService>(),
            get<_i3.AdminLeaveService>(),
          ));
  gh.factory<_i10.EmployeesCalenderBloc>(() => _i10.EmployeesCalenderBloc());
  gh.factory<_i11.LeaveCalendarBloc>(() => _i11.LeaveCalendarBloc());
  gh.factory<_i12.NetworkConnectionBloc>(
      () => _i12.NetworkConnectionBloc(get<_i6.Connectivity>()));
  gh.singleton<_i13.PaidLeaveService>(_i13.PaidLeaveService());
  await gh.factoryAsync<_i14.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.factory<_i15.UserEmployeesBloc>(
      () => _i15.UserEmployeesBloc(get<_i8.EmployeeService>()));
  gh.singleton<_i16.UserLeaveService>(_i16.UserLeaveService());
  gh.singleton<_i17.UserPreference>(
      _i17.UserPreference(get<_i14.SharedPreferences>()));
  gh.factory<_i18.WhoIsOutCardBloc>(() => _i18.WhoIsOutCardBloc(
        get<_i8.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
      ));
  gh.factory<_i19.AddMemberBloc>(
      () => _i19.AddMemberBloc(get<_i8.EmployeeService>()));
  gh.factory<_i20.AdminEditEmployeeDetailsBloc>(
      () => _i20.AdminEditEmployeeDetailsBloc(get<_i8.EmployeeService>()));
  gh.factory<_i21.AdminHomeBloc>(() => _i21.AdminHomeBloc(
        get<_i3.AdminLeaveService>(),
        get<_i8.EmployeeService>(),
        get<_i16.UserLeaveService>(),
        get<_i13.PaidLeaveService>(),
      ));
  gh.factory<_i22.AdminLeaveApplicationDetailsBloc>(
      () => _i22.AdminLeaveApplicationDetailsBloc(
            get<_i16.UserLeaveService>(),
            get<_i3.AdminLeaveService>(),
            get<_i13.PaidLeaveService>(),
          ));
  gh.factory<_i23.AdminSettingUpdatePaidLeaveCountBloc>(() =>
      _i23.AdminSettingUpdatePaidLeaveCountBloc(get<_i13.PaidLeaveService>()));
  gh.singleton<_i24.AuthService>(_i24.AuthService(
    get<_i7.DesktopAuthManager>(),
    get<_i17.UserPreference>(),
  ));
  gh.factory<_i25.EmployeeListBloc>(
      () => _i25.EmployeeListBloc(get<_i8.EmployeeService>()));
  gh.factory<_i26.UserLeaveCalendarBloc>(() => _i26.UserLeaveCalendarBloc(
        get<_i16.UserLeaveService>(),
        get<_i8.EmployeeService>(),
        get<_i13.PaidLeaveService>(),
      ));
  gh.singleton<_i27.UserManager>(_i27.UserManager(get<_i17.UserPreference>()));
  gh.factory<_i28.UserSettingsBloc>(() => _i28.UserSettingsBloc(
        get<_i27.UserManager>(),
        get<_i24.AuthService>(),
        get<_i17.UserPreference>(),
      ));
  gh.factory<_i29.AdminSettingsBloc>(() => _i29.AdminSettingsBloc(
        get<_i27.UserManager>(),
        get<_i24.AuthService>(),
        get<_i17.UserPreference>(),
      ));
  gh.factory<_i30.AllLeavesBloc>(() => _i30.AllLeavesBloc(
        get<_i27.UserManager>(),
        get<_i16.UserLeaveService>(),
        get<_i13.PaidLeaveService>(),
      ));
  gh.factory<_i31.AppRouter>(() => _i31.AppRouter(get<_i27.UserManager>()));
  gh.factory<_i32.ApplyLeaveBloc>(() => _i32.ApplyLeaveBloc(
        get<_i27.UserManager>(),
        get<_i13.PaidLeaveService>(),
        get<_i16.UserLeaveService>(),
      ));
  gh.singleton<_i33.AuthManager>(_i33.AuthManager(
    get<_i17.UserPreference>(),
    get<_i24.AuthService>(),
  ));
  gh.factory<_i34.EmployeeDetailBloc>(() => _i34.EmployeeDetailBloc(
        get<_i8.EmployeeService>(),
        get<_i16.UserLeaveService>(),
        get<_i27.UserManager>(),
      ));
  gh.factory<_i35.EmployeeEditEmployeeDetailsBloc>(
      () => _i35.EmployeeEditEmployeeDetailsBloc(
            get<_i8.EmployeeService>(),
            get<_i17.UserPreference>(),
            get<_i27.UserManager>(),
          ));
  gh.factory<_i36.LeaveDetailsBloc>(() => _i36.LeaveDetailsBloc(
        get<_i16.UserLeaveService>(),
        get<_i13.PaidLeaveService>(),
        get<_i27.UserManager>(),
      ));
  gh.factory<_i37.LogOutBloc>(() => _i37.LogOutBloc(
        get<_i17.UserPreference>(),
        get<_i24.AuthService>(),
        get<_i27.UserManager>(),
      ));
  gh.factory<_i38.LoginBloc>(() => _i38.LoginBloc(
        get<_i33.AuthManager>(),
        get<_i27.UserManager>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i39.RequestedLeavesViewBloc>(() => _i39.RequestedLeavesViewBloc(
        get<_i13.PaidLeaveService>(),
        get<_i16.UserLeaveService>(),
        get<_i27.UserManager>(),
      ));
  gh.factory<_i40.UpcomingLeavesViewBloc>(() => _i40.UpcomingLeavesViewBloc(
        get<_i13.PaidLeaveService>(),
        get<_i16.UserLeaveService>(),
        get<_i27.UserManager>(),
      ));
  gh.factory<_i41.UserHomeBloc>(() => _i41.UserHomeBloc(
        get<_i17.UserPreference>(),
        get<_i24.AuthService>(),
        get<_i27.UserManager>(),
      ));
  return get;
}

class _$AppModule extends _i42.AppModule {}
