// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../bloc/admin/absence/absence_bloc.dart' as _i12;
import '../bloc/admin/employee/add_memeber_bloc.dart' as _i24;
import '../bloc/admin/employee/employee_detail_bloc.dart' as _i16;
import '../bloc/admin/employee_list/employee_list_bloc.dart' as _i17;
import '../bloc/admin/home/admin_home_screen_bloc.dart' as _i13;
import '../bloc/admin/leave_details/admin_leave_details_bloc.dart' as _i14;
import '../bloc/admin/setting/total_paid_leave_count_bloc.dart' as _i25;
import '../bloc/authentication/login_bloc.dart' as _i18;
import '../bloc/authentication/logout_bloc.dart' as _i27;
import '../bloc/employee/home/employee_home_bloc.dart' as _i20;
import '../bloc/employee/leave/apply_leave_bloc.dart' as _i26;
import '../bloc/employee/leave/user_leave_bloc.dart' as _i23;
import '../bloc/network/network_service_bloc.dart' as _i7;
import '../navigation/navigation_stack_manager.dart' as _i22;
import '../pref/user_preference.dart' as _i11;
import '../provider/user_data.dart' as _i19;
import '../services/auth/auth_service.dart' as _i4;
import '../services/employee/employee_service.dart' as _i5;
import '../services/leave/admin_leave_service.dart' as _i3;
import '../services/leave/paid_leave_service.dart' as _i8;
import '../services/leave/user_leave_service.dart' as _i10;
import '../stateManager/admin/leave_status_manager.dart' as _i6;
import '../stateManager/auth/auth_manager.dart' as _i15;
import '../stateManager/login_state_manager.dart' as _i21;
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
  gh.singleton<_i5.EmployeeService>(_i5.EmployeeService());
  gh.singleton<_i6.LeaveStatusManager>(
      _i6.LeaveStatusManager(get<_i3.AdminLeaveService>()));
  gh.singleton<_i7.NetworkServiceBloc>(_i7.NetworkServiceBloc());
  gh.singleton<_i8.PaidLeaveService>(_i8.PaidLeaveService());
  await gh.factoryAsync<_i9.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.singleton<_i10.UserLeaveService>(_i10.UserLeaveService());
  gh.factory<_i11.UserPreference>(
      () => _i11.UserPreference(get<_i9.SharedPreferences>()));
  gh.factory<_i12.AbsenceBloc>(() => _i12.AbsenceBloc(
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
      ));
  gh.factory<_i13.AdminHomeScreenBloc>(() => _i13.AdminHomeScreenBloc(
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i10.UserLeaveService>(),
        get<_i8.PaidLeaveService>(),
      ));
  gh.factory<_i14.AdminLeaveDetailsScreenBloc>(
      () => _i14.AdminLeaveDetailsScreenBloc(
            get<_i10.UserLeaveService>(),
            get<_i8.PaidLeaveService>(),
          ));
  gh.singleton<_i15.AuthManager>(_i15.AuthManager(
    get<_i11.UserPreference>(),
    get<_i4.AuthService>(),
  ));
  gh.singleton<_i16.EmployeeDetailBloc>(
      _i16.EmployeeDetailBloc(get<_i5.EmployeeService>()));
  gh.factory<_i17.EmployeeListBloc>(
      () => _i17.EmployeeListBloc(get<_i5.EmployeeService>()));
  gh.factory<_i18.LoginBloc>(() => _i18.LoginBloc(get<_i15.AuthManager>()));
  gh.singleton<_i19.UserManager>(_i19.UserManager(get<_i11.UserPreference>()));
  gh.factory<_i20.EmployeeHomeBLoc>(() => _i20.EmployeeHomeBLoc(
        get<_i19.UserManager>(),
        get<_i10.UserLeaveService>(),
        get<_i8.PaidLeaveService>(),
      ));
  gh.singleton<_i21.LoginState>(_i21.LoginState(get<_i19.UserManager>()));
  gh.lazySingleton<_i22.NavigationStackManager>(
    () => _i22.NavigationStackManager(get<_i19.UserManager>()),
    dispose: (i) => i.dispose(),
  );
  gh.singleton<_i23.UserLeavesBloc>(_i23.UserLeavesBloc(
    get<_i10.UserLeaveService>(),
    get<_i19.UserManager>(),
  ));
  gh.factory<_i24.AddMemberBloc>(() => _i24.AddMemberBloc(
        get<_i5.EmployeeService>(),
        get<_i22.NavigationStackManager>(),
      ));
  gh.factory<_i25.AdminPaidLeaveCountBloc>(() => _i25.AdminPaidLeaveCountBloc(
        get<_i8.PaidLeaveService>(),
        get<_i22.NavigationStackManager>(),
      ));
  gh.factory<_i26.ApplyLeaveBloc>(() => _i26.ApplyLeaveBloc(
        get<_i19.UserManager>(),
        get<_i10.UserLeaveService>(),
        get<_i22.NavigationStackManager>(),
      ));
  gh.factory<_i27.LogOutBloc>(() => _i27.LogOutBloc(
        get<_i21.LoginState>(),
        get<_i11.UserPreference>(),
      ));
  return get;
}

class _$AppModule extends _i28.AppModule {}
