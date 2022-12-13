// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../bloc/authentication/logout_bloc.dart' as _i31;
import '../bloc/employee/leave/request_leave_bloc.dart' as _i19;
import '../bloc/employee/leave/user_leave_bloc.dart' as _i21;
import '../bloc/network/network_connection_bloc.dart' as _i8;
import '../bloc/shared/leave_details/leave_details_bloc.dart' as _i30;
import '../navigation/navigation_stack_manager.dart' as _i17;
import '../pref/user_preference.dart' as _i13;
import '../provider/user_data.dart' as _i16;
import '../services/admin/employee/employee_service.dart' as _i6;
import '../services/admin/paid_leave/paid_leave_service.dart' as _i10;
import '../services/admin/requests/admin_leave_service.dart' as _i3;
import '../services/auth/auth_service.dart' as _i5;
import '../services/leave/user_leave_service.dart' as _i12;
import '../stateManager/auth/auth_manager.dart' as _i15;
import '../ui/admin/addmember/bloc/add_member_bloc.dart' as _i23;
import '../ui/admin/employee/detail/bloc/employee_detail_bloc.dart' as _i27;
import '../ui/admin/employee/list/bloc/employee_list_bloc.dart' as _i29;
import '../ui/admin/home/bloc/admin_home_bloc.dart' as _i24;
import '../ui/admin/setting/bloc/admin_setting_screen_bloc.dart' as _i25;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i26;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i4;
import '../ui/login/bloc/login_view_bloc.dart' as _i32;
import '../ui/onboard/bloc/onboard_bloc.dart' as _i18;
import '../ui/shared/user_leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i7;
import '../ui/shared/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i20;
import '../ui/shared/who_is_out_calendar/bloc/who_is_out_calendar_bloc/who_is_out_calendar_bloc.dart'
    as _i14;
import '../ui/shared/who_is_out_calendar/bloc/who_is_out_view_bloc/who_is_out_view_bloc.dart'
    as _i22;
import '../ui/user/home/bloc/employee_home_bloc.dart' as _i28;
import 'AppModule.dart' as _i33; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i5.AuthService>(_i5.AuthService());
  gh.singleton<_i6.EmployeeService>(
    _i6.EmployeeService(),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i7.LeaveCalendarBloc>(() => _i7.LeaveCalendarBloc());
  gh.factory<_i8.NetworkConnectionBloc>(
      () => _i8.NetworkConnectionBloc(get<_i9.Connectivity>()));
  gh.singleton<_i10.PaidLeaveService>(_i10.PaidLeaveService());
  await gh.factoryAsync<_i11.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.singleton<_i12.UserLeaveService>(_i12.UserLeaveService());
  gh.factory<_i13.UserPreference>(
      () => _i13.UserPreference(get<_i11.SharedPreferences>()));
  gh.factory<_i14.WhoIsOutCalendarBloc>(() => _i14.WhoIsOutCalendarBloc());
  gh.singleton<_i15.AuthManager>(_i15.AuthManager(
    get<_i13.UserPreference>(),
    get<_i5.AuthService>(),
  ));
  gh.singleton<_i16.UserManager>(_i16.UserManager(get<_i13.UserPreference>()));
  gh.singleton<_i17.NavigationStackManager>(
    _i17.NavigationStackManager(get<_i16.UserManager>()),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i18.OnBoardBloc>(() => _i18.OnBoardBloc(
        get<_i13.UserPreference>(),
        get<_i17.NavigationStackManager>(),
      ));
  gh.factory<_i19.RequestLeaveBloc>(() => _i19.RequestLeaveBloc(
        get<_i16.UserManager>(),
        get<_i12.UserLeaveService>(),
        get<_i17.NavigationStackManager>(),
        get<_i10.PaidLeaveService>(),
      ));
  gh.factory<_i20.UserLeaveCalendarViewBloc>(
      () => _i20.UserLeaveCalendarViewBloc(
            get<_i12.UserLeaveService>(),
            get<_i17.NavigationStackManager>(),
            get<_i6.EmployeeService>(),
            get<_i10.PaidLeaveService>(),
          ));
  gh.factory<_i21.UserLeavesBloc>(() => _i21.UserLeavesBloc(
        get<_i12.UserLeaveService>(),
        get<_i16.UserManager>(),
        get<_i17.NavigationStackManager>(),
      ));
  gh.factory<_i22.WhoIsOutViewBloc>(() => _i22.WhoIsOutViewBloc(
        get<_i6.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i17.NavigationStackManager>(),
      ));
  gh.factory<_i23.AddMemberBloc>(() => _i23.AddMemberBloc(
        get<_i6.EmployeeService>(),
        get<_i17.NavigationStackManager>(),
      ));
  gh.factory<_i24.AdminHomeBloc>(() => _i24.AdminHomeBloc(
        get<_i17.NavigationStackManager>(),
        get<_i3.AdminLeaveService>(),
        get<_i6.EmployeeService>(),
        get<_i12.UserLeaveService>(),
        get<_i10.PaidLeaveService>(),
      ));
  gh.factory<_i25.AdminSettingScreenBLoc>(
      () => _i25.AdminSettingScreenBLoc(get<_i17.NavigationStackManager>()));
  gh.factory<_i26.AdminSettingUpdatePaidLeaveCountBloc>(
      () => _i26.AdminSettingUpdatePaidLeaveCountBloc(
            get<_i10.PaidLeaveService>(),
            get<_i17.NavigationStackManager>(),
          ));
  gh.factory<_i27.EmployeeDetailBloc>(() => _i27.EmployeeDetailBloc(
        get<_i17.NavigationStackManager>(),
        get<_i6.EmployeeService>(),
      ));
  gh.factory<_i28.EmployeeHomeBloc>(() => _i28.EmployeeHomeBloc(
        get<_i16.UserManager>(),
        get<_i12.UserLeaveService>(),
        get<_i10.PaidLeaveService>(),
        get<_i6.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i17.NavigationStackManager>(),
      ));
  gh.factory<_i29.EmployeeListBloc>(() => _i29.EmployeeListBloc(
        get<_i17.NavigationStackManager>(),
        get<_i6.EmployeeService>(),
      ));
  gh.factory<_i30.LeaveDetailBloc>(() => _i30.LeaveDetailBloc(
        get<_i12.UserLeaveService>(),
        get<_i17.NavigationStackManager>(),
        get<_i3.AdminLeaveService>(),
        get<_i16.UserManager>(),
      ));
  gh.factory<_i31.LogOutBloc>(() => _i31.LogOutBloc(
        get<_i17.NavigationStackManager>(),
        get<_i13.UserPreference>(),
        get<_i5.AuthService>(),
      ));
  gh.factory<_i32.LoginBloc>(() => _i32.LoginBloc(
        get<_i15.AuthManager>(),
        get<_i16.UserManager>(),
        get<_i17.NavigationStackManager>(),
        get<_i5.AuthService>(),
      ));
  return get;
}

class _$AppModule extends _i33.AppModule {}
