// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

import '../bloc/authentication/logout_bloc.dart' as _i32;
import '../bloc/network/network_connection_bloc.dart' as _i10;
import '../pref/user_preference.dart' as _i15;
import '../provider/user_data.dart' as _i25;
import '../router/app_router.dart' as _i27;
import '../services/admin/employee/employee_service.dart' as _i7;
import '../services/admin/paid_leave/paid_leave_service.dart' as _i12;
import '../services/admin/requests/admin_leave_service.dart' as _i3;
import '../services/auth/auth_service.dart' as _i6;
import '../services/leave/user_leave_service.dart' as _i14;
import '../stateManager/auth/auth_manager.dart' as _i22;
import '../ui/admin/addmember/bloc/add_member_bloc.dart' as _i17;
import '../ui/admin/edit_employe_details/bloc/edit_employee_details_bloc.dart'
    as _i18;
import '../ui/admin/employee/detail/bloc/employee_detail_bloc.dart' as _i28;
import '../ui/admin/employee/list/bloc/employee_list_bloc.dart' as _i23;
import '../ui/admin/home/bloc/admin_home_bloc.dart' as _i19;
import '../ui/admin/leave_details/bloc/admin_leave_details_bloc.dart' as _i20;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i21;
import '../ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i4;
import '../ui/login/bloc/login_view_bloc.dart' as _i33;
import '../ui/shared/user_leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i9;
import '../ui/shared/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i24;
import '../ui/shared/who_is_out_calendar/bloc/who_is_out_calendar_bloc/who_is_out_calendar_bloc.dart'
    as _i8;
import '../ui/shared/who_is_out_calendar/bloc/who_is_out_view_bloc/who_is_out_view_bloc.dart'
    as _i16;
import '../ui/user/all_leaves/bloc/filter_bloc/all_leaves_filter_bloc.dart'
    as _i5;
import '../ui/user/all_leaves/bloc/leaves_bloc/all_leaves_bloc.dart' as _i26;
import '../ui/user/home/bloc/employee_home_bloc.dart' as _i29;
import '../ui/user/leave/applyLeave/bloc/leave_request_form_bloc/leave_request_view_bloc.dart'
    as _i31;
import '../ui/user/leave_details/bloc/leave_details_bloc/employee_leave_details_bloc.dart'
    as _i30;
import '../ui/user/requested_leaves/bloc/requested_leaves_bloc.dart' as _i34;
import '../ui/user/upcoming_leaves/bloc/upcoming_leaves_bloc.dart' as _i35;
import 'app_module.dart' as _i36; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i6.AuthService>(_i6.AuthService());
  gh.singleton<_i7.EmployeeService>(
    _i7.EmployeeService(),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i8.EmployeesCalenderBloc>(() => _i8.EmployeesCalenderBloc());
  gh.factory<_i9.LeaveCalendarBloc>(() => _i9.LeaveCalendarBloc());
  gh.factory<_i10.NetworkConnectionBloc>(
      () => _i10.NetworkConnectionBloc(get<_i11.Connectivity>()));
  gh.singleton<_i12.PaidLeaveService>(_i12.PaidLeaveService());
  await gh.factoryAsync<_i13.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.singleton<_i14.UserLeaveService>(_i14.UserLeaveService());
  gh.factory<_i15.UserPreference>(
      () => _i15.UserPreference(get<_i13.SharedPreferences>()));
  gh.factory<_i16.WhoIsOutViewBloc>(() => _i16.WhoIsOutViewBloc(
        get<_i7.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
      ));
  gh.factory<_i17.AddMemberBloc>(
      () => _i17.AddMemberBloc(get<_i7.EmployeeService>()));
  gh.factory<_i18.AdminEditEmployeeDetailsBloc>(
      () => _i18.AdminEditEmployeeDetailsBloc(get<_i7.EmployeeService>()));
  gh.factory<_i19.AdminHomeBloc>(() => _i19.AdminHomeBloc(
        get<_i3.AdminLeaveService>(),
        get<_i7.EmployeeService>(),
        get<_i14.UserLeaveService>(),
        get<_i12.PaidLeaveService>(),
      ));
  gh.factory<_i20.AdminLeaveDetailsBloc>(() => _i20.AdminLeaveDetailsBloc(
        get<_i14.UserLeaveService>(),
        get<_i3.AdminLeaveService>(),
        get<_i12.PaidLeaveService>(),
      ));
  gh.factory<_i21.AdminSettingUpdatePaidLeaveCountBloc>(() =>
      _i21.AdminSettingUpdatePaidLeaveCountBloc(get<_i12.PaidLeaveService>()));
  gh.singleton<_i22.AuthManager>(_i22.AuthManager(
    get<_i15.UserPreference>(),
    get<_i6.AuthService>(),
  ));
  gh.factory<_i23.EmployeeListBloc>(
      () => _i23.EmployeeListBloc(get<_i7.EmployeeService>()));
  gh.factory<_i24.UserLeaveCalendarViewBloc>(
      () => _i24.UserLeaveCalendarViewBloc(
            get<_i14.UserLeaveService>(),
            get<_i7.EmployeeService>(),
            get<_i12.PaidLeaveService>(),
          ));
  gh.singleton<_i25.UserManager>(_i25.UserManager(get<_i15.UserPreference>()));
  gh.factory<_i26.AllLeavesViewBloc>(() => _i26.AllLeavesViewBloc(
        get<_i25.UserManager>(),
        get<_i14.UserLeaveService>(),
        get<_i12.PaidLeaveService>(),
      ));
  gh.factory<_i27.AppRouter>(() => _i27.AppRouter(get<_i25.UserManager>()));
  gh.factory<_i28.EmployeeDetailBloc>(() => _i28.EmployeeDetailBloc(
        get<_i7.EmployeeService>(),
        get<_i14.UserLeaveService>(),
        get<_i25.UserManager>(),
      ));
  gh.factory<_i29.EmployeeHomeBloc>(() => _i29.EmployeeHomeBloc(
        get<_i25.UserManager>(),
        get<_i14.UserLeaveService>(),
        get<_i12.PaidLeaveService>(),
        get<_i7.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
      ));
  gh.factory<_i30.EmployeeLeaveDetailsBloc>(() => _i30.EmployeeLeaveDetailsBloc(
        get<_i14.UserLeaveService>(),
        get<_i12.PaidLeaveService>(),
        get<_i25.UserManager>(),
      ));
  gh.factory<_i31.LeaveRequestBloc>(() => _i31.LeaveRequestBloc(
        get<_i25.UserManager>(),
        get<_i12.PaidLeaveService>(),
        get<_i14.UserLeaveService>(),
      ));
  gh.factory<_i32.LogOutBloc>(() => _i32.LogOutBloc(
        get<_i15.UserPreference>(),
        get<_i6.AuthService>(),
        get<_i25.UserManager>(),
      ));
  gh.factory<_i33.LoginBloc>(() => _i33.LoginBloc(
        get<_i22.AuthManager>(),
        get<_i25.UserManager>(),
        get<_i6.AuthService>(),
      ));
  gh.factory<_i34.RequestedLeavesViewBloc>(() => _i34.RequestedLeavesViewBloc(
        get<_i12.PaidLeaveService>(),
        get<_i14.UserLeaveService>(),
        get<_i25.UserManager>(),
      ));
  gh.factory<_i35.UpcomingLeavesViewBloc>(() => _i35.UpcomingLeavesViewBloc(
        get<_i12.PaidLeaveService>(),
        get<_i14.UserLeaveService>(),
        get<_i25.UserManager>(),
      ));
  return get;
}

class _$AppModule extends _i36.AppModule {}
