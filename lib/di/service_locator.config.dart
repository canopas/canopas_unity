// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../bloc/admin/home/add_memeber_bloc.dart' as _i22;
import '../bloc/authentication/login_bloc.dart' as _i30;
import '../bloc/authentication/logout_bloc.dart' as _i29;
import '../bloc/employee/leave/request_leave_bloc.dart' as _i18;
import '../bloc/employee/leave/user_leave_bloc.dart' as _i20;
import '../bloc/network/network_service_bloc.dart' as _i8;
import '../bloc/shared/leave_details/leave_details_bloc.dart' as _i28;
import '../navigation/navigation_stack_manager.dart' as _i16;
import '../pref/user_preference.dart' as _i12;
import '../provider/user_data.dart' as _i15;
import '../services/admin/employee/employee_service.dart' as _i6;
import '../services/admin/paid_leave/paid_leave_service.dart' as _i9;
import '../services/admin/requests/admin_leave_service.dart' as _i3;
import '../services/auth/auth_service.dart' as _i5;
import '../services/leave/user_leave_service.dart' as _i11;
import '../stateManager/auth/auth_manager.dart' as _i14;
import '../ui/admin/employee/detail/bloc/employee_detail_bloc.dart' as _i25;
import '../ui/admin/employee/list/bloc/employee_list_bloc.dart' as _i27;
import '../ui/admin/home/bloc/admin_home_bloc.dart' as _i23;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i24;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i4;
import '../ui/onboard/bloc/onboard_bloc.dart' as _i17;
import '../ui/shared/user_leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i7;
import '../ui/shared/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i19;
import '../ui/shared/who_is_out_calendar/bloc/who_is_out_calendar_bloc/who_is_out_calendar_bloc.dart'
    as _i13;
import '../ui/shared/who_is_out_calendar/bloc/who_is_out_view_bloc/who_is_out_view_bloc.dart'
    as _i21;
import '../ui/user/home/bloc/employee_home_bloc.dart' as _i26;
import 'AppModule.dart' as _i31; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.AdminLeaveService>(() => _i3.AdminLeaveService());
  gh.factory<_i4.AdminPaidLeaveUpdateSettingTextFieldBloc>(
      () => _i4.AdminPaidLeaveUpdateSettingTextFieldBloc());
  gh.singleton<_i5.AuthService>(_i5.AuthService());
  gh.factory<_i6.EmployeeService>(() => _i6.EmployeeService());
  gh.factory<_i7.LeaveCalendarBloc>(() => _i7.LeaveCalendarBloc());
  gh.factory<_i8.NetworkServiceBloc>(() => _i8.NetworkServiceBloc());
  gh.factory<_i9.PaidLeaveService>(() => _i9.PaidLeaveService());
  await gh.factoryAsync<_i10.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.singleton<_i11.UserLeaveService>(_i11.UserLeaveService());
  gh.factory<_i12.UserPreference>(
      () => _i12.UserPreference(get<_i10.SharedPreferences>()));
  gh.factory<_i13.WhoIsOutCalendarBloc>(() => _i13.WhoIsOutCalendarBloc());
  gh.singleton<_i14.AuthManager>(_i14.AuthManager(
    get<_i12.UserPreference>(),
    get<_i5.AuthService>(),
  ));
  gh.singleton<_i15.UserManager>(_i15.UserManager(get<_i12.UserPreference>()));
  gh.singleton<_i16.NavigationStackManager>(
    _i16.NavigationStackManager(get<_i15.UserManager>()),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i17.OnBoardBloc>(() => _i17.OnBoardBloc(
        get<_i12.UserPreference>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i18.RequestLeaveBloc>(() => _i18.RequestLeaveBloc(
        get<_i15.UserManager>(),
        get<_i11.UserLeaveService>(),
        get<_i16.NavigationStackManager>(),
        get<_i9.PaidLeaveService>(),
      ));
  gh.factory<_i19.UserLeaveCalendarViewBloc>(
      () => _i19.UserLeaveCalendarViewBloc(
            get<_i11.UserLeaveService>(),
            get<_i16.NavigationStackManager>(),
            get<_i6.EmployeeService>(),
            get<_i9.PaidLeaveService>(),
          ));
  gh.factory<_i20.UserLeavesBloc>(() => _i20.UserLeavesBloc(
        get<_i11.UserLeaveService>(),
        get<_i15.UserManager>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i21.WhoIsOutViewBloc>(() => _i21.WhoIsOutViewBloc(
        get<_i6.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i22.AddMemberBloc>(() => _i22.AddMemberBloc(
        get<_i6.EmployeeService>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i23.AdminHomeBloc>(() => _i23.AdminHomeBloc(
        get<_i16.NavigationStackManager>(),
        get<_i3.AdminLeaveService>(),
        get<_i6.EmployeeService>(),
        get<_i11.UserLeaveService>(),
        get<_i9.PaidLeaveService>(),
      ));
  gh.factory<_i24.AdminSettingUpdatePaidLeaveCountBloc>(
      () => _i24.AdminSettingUpdatePaidLeaveCountBloc(
            get<_i9.PaidLeaveService>(),
            get<_i16.NavigationStackManager>(),
          ));
  gh.factory<_i25.EmployeeDetailBloc>(() => _i25.EmployeeDetailBloc(
        get<_i16.NavigationStackManager>(),
        get<_i6.EmployeeService>(),
      ));
  gh.factory<_i26.EmployeeHomeBloc>(() => _i26.EmployeeHomeBloc(
        get<_i15.UserManager>(),
        get<_i11.UserLeaveService>(),
        get<_i9.PaidLeaveService>(),
        get<_i6.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i27.EmployeeListBloc>(() => _i27.EmployeeListBloc(
        get<_i16.NavigationStackManager>(),
        get<_i6.EmployeeService>(),
      ));
  gh.factory<_i28.LeaveDetailBloc>(() => _i28.LeaveDetailBloc(
        get<_i11.UserLeaveService>(),
        get<_i16.NavigationStackManager>(),
        get<_i3.AdminLeaveService>(),
        get<_i15.UserManager>(),
      ));
  gh.factory<_i29.LogOutBloc>(() => _i29.LogOutBloc(
        get<_i12.UserPreference>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i30.LoginBloc>(() => _i30.LoginBloc(
        get<_i14.AuthManager>(),
        get<_i16.NavigationStackManager>(),
        get<_i15.UserManager>(),
      ));
  return get;
}

class _$AppModule extends _i31.AppModule {}
