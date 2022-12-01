// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../bloc/admin/employee/employee_detail_bloc.dart' as _i24;
import '../bloc/admin/home/add_memeber_bloc.dart' as _i21;
import '../bloc/admin/setting/paid_leave_count_bloc.dart' as _i23;
import '../bloc/authentication/login_bloc.dart' as _i29;
import '../bloc/authentication/logout_bloc.dart' as _i28;
import '../bloc/employee/leave/request_leave_bloc.dart' as _i17;
import '../bloc/employee/leave/user_leave_bloc.dart' as _i19;
import '../bloc/network/network_service_bloc.dart' as _i7;
import '../bloc/shared/leave_details/leave_details_bloc.dart' as _i27;
import '../navigation/navigation_stack_manager.dart' as _i15;
import '../pref/user_preference.dart' as _i11;
import '../provider/user_data.dart' as _i14;
import '../services/admin/employee/employee_service.dart' as _i5;
import '../services/admin/paid_leave/paid_leave_service.dart' as _i8;
import '../services/admin/requests/admin_leave_service.dart' as _i3;
import '../services/auth/auth_service.dart' as _i4;
import '../services/leave/user_leave_service.dart' as _i10;
import '../stateManager/auth/auth_manager.dart' as _i13;
import '../ui/admin/employee/list/bloc/employee_list_bloc.dart' as _i26;
import '../ui/admin/home/bloc/admin_home_bloc.dart' as _i22;
import '../ui/onboard/bloc/onboard_bloc.dart' as _i16;
import '../ui/shared/user_leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i6;
import '../ui/shared/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i18;
import '../ui/shared/who_is_out_calendar/bloc/who_is_out_calendar_bloc/who_is_out_calendar_bloc.dart'
    as _i12;
import '../ui/shared/who_is_out_calendar/bloc/who_is_out_view_bloc/who_is_out_view_bloc.dart'
    as _i20;
import '../ui/user/home/bloc/employee_home_bloc.dart' as _i25;
import 'AppModule.dart' as _i30; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i6.LeaveCalendarBloc>(() => _i6.LeaveCalendarBloc());
  gh.factory<_i7.NetworkServiceBloc>(() => _i7.NetworkServiceBloc());
  gh.factory<_i8.PaidLeaveService>(() => _i8.PaidLeaveService());
  await gh.factoryAsync<_i9.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.singleton<_i10.UserLeaveService>(_i10.UserLeaveService());
  gh.factory<_i11.UserPreference>(
      () => _i11.UserPreference(get<_i9.SharedPreferences>()));
  gh.factory<_i12.WhoIsOutCalendarBloc>(() => _i12.WhoIsOutCalendarBloc());
  gh.singleton<_i13.AuthManager>(_i13.AuthManager(
    get<_i11.UserPreference>(),
    get<_i4.AuthService>(),
  ));
  gh.singleton<_i14.UserManager>(_i14.UserManager(get<_i11.UserPreference>()));
  gh.singleton<_i15.NavigationStackManager>(
    _i15.NavigationStackManager(get<_i14.UserManager>()),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i16.OnBoardBloc>(() => _i16.OnBoardBloc(
        get<_i11.UserPreference>(),
        get<_i15.NavigationStackManager>(),
      ));
  gh.factory<_i17.RequestLeaveBloc>(() => _i17.RequestLeaveBloc(
        get<_i14.UserManager>(),
        get<_i10.UserLeaveService>(),
        get<_i15.NavigationStackManager>(),
        get<_i8.PaidLeaveService>(),
      ));
  gh.factory<_i18.UserLeaveCalendarViewBloc>(
      () => _i18.UserLeaveCalendarViewBloc(
            get<_i10.UserLeaveService>(),
            get<_i15.NavigationStackManager>(),
            get<_i5.EmployeeService>(),
            get<_i8.PaidLeaveService>(),
          ));
  gh.factory<_i19.UserLeavesBloc>(() => _i19.UserLeavesBloc(
        get<_i10.UserLeaveService>(),
        get<_i14.UserManager>(),
        get<_i15.NavigationStackManager>(),
      ));
  gh.factory<_i20.WhoIsOutViewBloc>(() => _i20.WhoIsOutViewBloc(
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i15.NavigationStackManager>(),
      ));
  gh.factory<_i21.AddMemberBloc>(() => _i21.AddMemberBloc(
        get<_i5.EmployeeService>(),
        get<_i15.NavigationStackManager>(),
      ));
  gh.factory<_i22.AdminHomeBloc>(() => _i22.AdminHomeBloc(
        get<_i15.NavigationStackManager>(),
        get<_i3.AdminLeaveService>(),
        get<_i5.EmployeeService>(),
        get<_i10.UserLeaveService>(),
        get<_i8.PaidLeaveService>(),
      ));
  gh.factory<_i23.AdminPaidLeaveCountBloc>(() => _i23.AdminPaidLeaveCountBloc(
        get<_i8.PaidLeaveService>(),
        get<_i15.NavigationStackManager>(),
      ));
  gh.factory<_i24.EmployeeDetailBloc>(() => _i24.EmployeeDetailBloc(
        get<_i5.EmployeeService>(),
        get<_i15.NavigationStackManager>(),
        get<_i10.UserLeaveService>(),
      ));
  gh.factory<_i25.EmployeeHomeBloc>(() => _i25.EmployeeHomeBloc(
        get<_i14.UserManager>(),
        get<_i10.UserLeaveService>(),
        get<_i8.PaidLeaveService>(),
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i15.NavigationStackManager>(),
      ));
  gh.factory<_i26.EmployeeListBloc>(() => _i26.EmployeeListBloc(
        get<_i5.EmployeeService>(),
        get<_i15.NavigationStackManager>(),
      ));
  gh.factory<_i27.LeaveDetailBloc>(() => _i27.LeaveDetailBloc(
        get<_i10.UserLeaveService>(),
        get<_i15.NavigationStackManager>(),
        get<_i3.AdminLeaveService>(),
        get<_i14.UserManager>(),
      ));
  gh.factory<_i28.LogOutBloc>(() => _i28.LogOutBloc(
        get<_i11.UserPreference>(),
        get<_i15.NavigationStackManager>(),
      ));
  gh.factory<_i29.LoginBloc>(() => _i29.LoginBloc(
        get<_i13.AuthManager>(),
        get<_i15.NavigationStackManager>(),
        get<_i14.UserManager>(),
      ));
  return get;
}

class _$AppModule extends _i30.AppModule {}
