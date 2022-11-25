// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../bloc/admin/employee/employee_detail_bloc.dart' as _i22;
import '../bloc/admin/home/add_memeber_bloc.dart' as _i19;
import '../bloc/admin/setting/paid_leave_count_bloc.dart' as _i21;
import '../bloc/authentication/login_bloc.dart' as _i27;
import '../bloc/authentication/logout_bloc.dart' as _i26;
import '../bloc/employee/leave/request_leave_bloc.dart' as _i15;
import '../bloc/employee/leave/user_leave_bloc.dart' as _i17;
import '../bloc/network/network_service_bloc.dart' as _i6;
import '../bloc/onboard/onboard_bloc.dart' as _i14;
import '../bloc/shared/leave_details/leave_details_bloc.dart' as _i25;
import '../bloc/shared/user_leave_calendar/user_leave_calendar_bloc.dart'
    as _i16;
import '../bloc/shared/who_is_out_calendar/who_is_out_calendar_view_bloc.dart'
    as _i18;
import '../navigation/navigation_stack_manager.dart' as _i13;
import '../pref/user_preference.dart' as _i10;
import '../provider/user_data.dart' as _i12;
import '../services/admin/employee/employee_service.dart' as _i5;
import '../services/admin/paid_leave/paid_leave_service.dart' as _i7;
import '../services/admin/requests/admin_leave_service.dart' as _i3;
import '../services/auth/auth_service.dart' as _i4;
import '../services/leave/user_leave_service.dart' as _i9;
import '../stateManager/auth/auth_manager.dart' as _i11;
import '../ui/admin/employee/list/bloc/employee_list_bloc.dart' as _i24;
import '../ui/admin/home/bloc/admin_home_bloc.dart' as _i20;
import '../ui/user/home/bloc/employee_home_bloc.dart' as _i23;
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
  gh.singleton<_i11.AuthManager>(_i11.AuthManager(
    get<_i10.UserPreference>(),
    get<_i4.AuthService>(),
  ));
  gh.singleton<_i12.UserManager>(_i12.UserManager(get<_i10.UserPreference>()));
  gh.singleton<_i13.NavigationStackManager>(
    _i13.NavigationStackManager(get<_i12.UserManager>()),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i14.OnBoardBloc>(() => _i14.OnBoardBloc(
        get<_i10.UserPreference>(),
        get<_i13.NavigationStackManager>(),
      ));
  gh.factory<_i15.RequestLeaveBloc>(() => _i15.RequestLeaveBloc(
        get<_i12.UserManager>(),
        get<_i9.UserLeaveService>(),
        get<_i13.NavigationStackManager>(),
        get<_i7.PaidLeaveService>(),
      ));
  gh.factory<_i16.UserLeaveCalendarBloc>(() => _i16.UserLeaveCalendarBloc(
        get<_i13.NavigationStackManager>(),
        get<_i9.UserLeaveService>(),
        get<_i5.EmployeeService>(),
      ));
  gh.factory<_i17.UserLeavesBloc>(() => _i17.UserLeavesBloc(
        get<_i9.UserLeaveService>(),
        get<_i12.UserManager>(),
        get<_i13.NavigationStackManager>(),
      ));
  gh.factory<_i18.WhoIsOutCalendarBloc>(() => _i18.WhoIsOutCalendarBloc(
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i13.NavigationStackManager>(),
      ));
  gh.factory<_i19.AddMemberBloc>(() => _i19.AddMemberBloc(
        get<_i5.EmployeeService>(),
        get<_i13.NavigationStackManager>(),
      ));
  gh.factory<_i20.AdminHomeBloc>(() => _i20.AdminHomeBloc(
        get<_i13.NavigationStackManager>(),
        get<_i3.AdminLeaveService>(),
        get<_i5.EmployeeService>(),
        get<_i9.UserLeaveService>(),
        get<_i7.PaidLeaveService>(),
      ));
  gh.factory<_i21.AdminPaidLeaveCountBloc>(() => _i21.AdminPaidLeaveCountBloc(
        get<_i7.PaidLeaveService>(),
        get<_i13.NavigationStackManager>(),
      ));
  gh.factory<_i22.EmployeeDetailBloc>(() => _i22.EmployeeDetailBloc(
        get<_i5.EmployeeService>(),
        get<_i13.NavigationStackManager>(),
        get<_i9.UserLeaveService>(),
      ));
  gh.factory<_i23.EmployeeHomeBloc>(() => _i23.EmployeeHomeBloc(
        get<_i12.UserManager>(),
        get<_i9.UserLeaveService>(),
        get<_i7.PaidLeaveService>(),
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i13.NavigationStackManager>(),
      ));
  gh.factory<_i24.EmployeeListBloc>(() => _i24.EmployeeListBloc(
        get<_i5.EmployeeService>(),
        get<_i13.NavigationStackManager>(),
      ));
  gh.factory<_i25.LeaveDetailBloc>(() => _i25.LeaveDetailBloc(
        get<_i9.UserLeaveService>(),
        get<_i13.NavigationStackManager>(),
        get<_i3.AdminLeaveService>(),
        get<_i12.UserManager>(),
      ));
  gh.factory<_i26.LogOutBloc>(() => _i26.LogOutBloc(
        get<_i10.UserPreference>(),
        get<_i13.NavigationStackManager>(),
      ));
  gh.factory<_i27.LoginBloc>(() => _i27.LoginBloc(
        get<_i11.AuthManager>(),
        get<_i13.NavigationStackManager>(),
        get<_i12.UserManager>(),
      ));
  return get;
}

class _$AppModule extends _i28.AppModule {}
