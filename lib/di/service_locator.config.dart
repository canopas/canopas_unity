// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../bloc/admin/employee/employee_detail_bloc.dart' as _i24;
import '../bloc/admin/employee/employee_list_bloc.dart' as _i13;
import '../bloc/admin/home/add_memeber_bloc.dart' as _i21;
import '../bloc/admin/home/admin_home_screen_bloc.dart' as _i11;
import '../bloc/admin/setting/paid_leave_count_bloc.dart' as _i22;
import '../bloc/authentication/login_bloc.dart' as _i27;
import '../bloc/authentication/logout_bloc.dart' as _i26;
import '../bloc/employee/home/employee_home_bloc.dart' as _i15;
import '../bloc/employee/leave/apply_leave_bloc.dart' as _i23;
import '../bloc/employee/leave/user_leave_bloc.dart' as _i19;
import '../bloc/network/network_service_bloc.dart' as _i6;
import '../bloc/onboard/onboard_bloc.dart' as _i17;
import '../bloc/shared/leave_details/leave_details_bloc.dart' as _i25;
import '../bloc/shared/user_leave_calendar/user_leave_calendar_bloc.dart'
    as _i18;
import '../bloc/shared/who_is_out_calendar/who_is_out_calendar_view_bloc.dart'
    as _i20;
import '../navigation/navigation_stack_manager.dart' as _i16;
import '../pref/user_preference.dart' as _i10;
import '../provider/user_data.dart' as _i14;
import '../services/admin/employee/employee_service.dart' as _i5;
import '../services/admin/paid_leave/paid_leave_service.dart' as _i7;
import '../services/admin/requests/admin_leave_service.dart' as _i3;
import '../services/auth/auth_service.dart' as _i4;
import '../services/leave/user_leave_service.dart' as _i9;
import '../stateManager/auth/auth_manager.dart' as _i12;
import 'AppModule.dart' as _i28; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i4.AuthService>(_i4.AuthService());
  gh.factory<_i5.EmployeeService>(() => _i5.EmployeeService());
  gh.factory<_i6.NetworkServiceBloc>(() => _i6.NetworkServiceBloc());
  gh.factory<_i7.PaidLeaveService>(() => _i7.PaidLeaveService());
  await gh.factoryAsync<_i8.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.singleton<_i9.UserLeaveService>(_i9.UserLeaveService());
  gh.factory<_i10.UserPreference>(
      () => _i10.UserPreference(get<_i8.SharedPreferences>()));
  gh.factory<_i11.AdminHomeScreenBloc>(() => _i11.AdminHomeScreenBloc(
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i7.PaidLeaveService>(),
        get<_i9.UserLeaveService>(),
      ));
  gh.singleton<_i12.AuthManager>(_i12.AuthManager(
    get<_i10.UserPreference>(),
    get<_i4.AuthService>(),
  ));
  gh.factory<_i13.EmployeeListBloc>(
      () => _i13.EmployeeListBloc(get<_i5.EmployeeService>()));
  gh.singleton<_i14.UserManager>(_i14.UserManager(get<_i10.UserPreference>()));
  gh.factory<_i15.EmployeeHomeBLoc>(() => _i15.EmployeeHomeBLoc(
        get<_i14.UserManager>(),
        get<_i9.UserLeaveService>(),
        get<_i7.PaidLeaveService>(),
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
      ));
  gh.singleton<_i16.NavigationStackManager>(
    _i16.NavigationStackManager(get<_i14.UserManager>()),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i17.OnBoardBloc>(() => _i17.OnBoardBloc(
        get<_i10.UserPreference>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i18.UserLeaveCalendarBloc>(() => _i18.UserLeaveCalendarBloc(
        get<_i16.NavigationStackManager>(),
        get<_i9.UserLeaveService>(),
        get<_i5.EmployeeService>(),
      ));
  gh.factory<_i19.UserLeavesBloc>(() => _i19.UserLeavesBloc(
        get<_i9.UserLeaveService>(),
        get<_i14.UserManager>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i20.WhoIsOutCalendarBloc>(() => _i20.WhoIsOutCalendarBloc(
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i21.AddMemberBloc>(() => _i21.AddMemberBloc(
        get<_i5.EmployeeService>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i22.AdminPaidLeaveCountBloc>(() => _i22.AdminPaidLeaveCountBloc(
        get<_i7.PaidLeaveService>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i23.ApplyLeaveBloc>(() => _i23.ApplyLeaveBloc(
        get<_i14.UserManager>(),
        get<_i9.UserLeaveService>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i24.EmployeeDetailBloc>(() => _i24.EmployeeDetailBloc(
        get<_i5.EmployeeService>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i25.LeaveDetailBloc>(() => _i25.LeaveDetailBloc(
        get<_i9.UserLeaveService>(),
        get<_i7.PaidLeaveService>(),
        get<_i16.NavigationStackManager>(),
        get<_i3.AdminLeaveService>(),
        get<_i14.UserManager>(),
      ));
  gh.factory<_i26.LogOutBloc>(() => _i26.LogOutBloc(
        get<_i10.UserPreference>(),
        get<_i16.NavigationStackManager>(),
      ));
  gh.factory<_i27.LoginBloc>(() => _i27.LoginBloc(
        get<_i12.AuthManager>(),
        get<_i16.NavigationStackManager>(),
        get<_i14.UserManager>(),
      ));
  return get;
}

class _$AppModule extends _i28.AppModule {}
