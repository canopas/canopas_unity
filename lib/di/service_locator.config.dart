// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../bloc/admin/admin_home_screen_bloc/admin_home_screen_bloc.dart'
    as _i15;
import '../bloc/admin/employee/employee_detail_bloc.dart' as _i18;
import '../bloc/admin/employee/employee_list_bloc.dart' as _i19;
import '../bloc/admin/employee/employee_validation.dart' as _i6;
import '../bloc/admin/leave/absence_bloc.dart' as _i14;
import '../bloc/admin/leave_details_screen/admin_leave_details_bloc.dart'
    as _i16;
import '../bloc/admin/update_paid_leave_count/total_paid_leave_count_bloc.dart'
    as _i26;
import '../bloc/authentication/login_bloc.dart' as _i20;
import '../bloc/authentication/logout_bloc.dart' as _i27;
import '../bloc/employee/employee_leave_count/employee_home_bloc.dart' as _i22;
import '../bloc/network/network_service_bloc.dart' as _i9;
import '../bloc/user/user_leave_bloc.dart' as _i25;
import '../navigation/navigation_stack_manager.dart' as _i24;
import '../pref/user_preference.dart' as _i13;
import '../provider/user_data.dart' as _i21;
import '../services/auth/auth_service.dart' as _i4;
import '../services/employee/employee_service.dart' as _i5;
import '../services/leave/admin_leave_service.dart' as _i3;
import '../services/leave/paid_leave_service.dart' as _i10;
import '../services/leave/user_leave_service.dart' as _i12;
import '../stateManager/admin/leave_status_manager.dart' as _i8;
import '../stateManager/auth/auth_manager.dart' as _i17;
import '../stateManager/login_state_manager.dart' as _i23;
import '../stateManager/user/leave_request_data_manager.dart' as _i7;
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
  gh.singleton<_i6.EmployeeValidationBloc>(_i6.EmployeeValidationBloc());
  gh.singleton<_i7.LeaveRequestDataManager>(_i7.LeaveRequestDataManager());
  gh.singleton<_i8.LeaveStatusManager>(
      _i8.LeaveStatusManager(get<_i3.AdminLeaveService>()));
  gh.singleton<_i9.NetworkServiceBloc>(_i9.NetworkServiceBloc());
  gh.singleton<_i10.PaidLeaveService>(_i10.PaidLeaveService());
  await gh.factoryAsync<_i11.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.singleton<_i12.UserLeaveService>(_i12.UserLeaveService());
  gh.factory<_i13.UserPreference>(
      () => _i13.UserPreference(get<_i11.SharedPreferences>()));
  gh.singleton<_i14.AbsenceBloc>(_i14.AbsenceBloc(
    get<_i5.EmployeeService>(),
    get<_i3.AdminLeaveService>(),
  ));
  gh.factory<_i15.AdminHomeScreenBloc>(() => _i15.AdminHomeScreenBloc(
        get<_i5.EmployeeService>(),
        get<_i3.AdminLeaveService>(),
        get<_i12.UserLeaveService>(),
        get<_i10.PaidLeaveService>(),
      ));
  gh.singleton<_i16.AdminLeaveDetailsScreenBloc>(
      _i16.AdminLeaveDetailsScreenBloc(
    get<_i12.UserLeaveService>(),
    get<_i10.PaidLeaveService>(),
  ));
  gh.singleton<_i17.AuthManager>(_i17.AuthManager(
    get<_i13.UserPreference>(),
    get<_i4.AuthService>(),
  ));
  gh.singleton<_i18.EmployeeDetailBloc>(
      _i18.EmployeeDetailBloc(get<_i5.EmployeeService>()));
  gh.singleton<_i19.EmployeeListBloc>(
      _i19.EmployeeListBloc(get<_i5.EmployeeService>()));
  gh.singleton<_i20.LoginBloc>(_i20.LoginBloc(get<_i17.AuthManager>()));
  gh.singleton<_i21.UserManager>(_i21.UserManager(get<_i13.UserPreference>()));
  gh.factory<_i22.EmployeeHomeBLoc>(() => _i22.EmployeeHomeBLoc(
        get<_i21.UserManager>(),
        get<_i12.UserLeaveService>(),
        get<_i10.PaidLeaveService>(),
      ));
  gh.singleton<_i23.LoginState>(_i23.LoginState(get<_i21.UserManager>()));
  gh.lazySingleton<_i24.NavigationStackManager>(
    () => _i24.NavigationStackManager(get<_i21.UserManager>()),
    dispose: (i) => i.dispose(),
  );
  gh.singleton<_i25.UserLeavesBloc>(_i25.UserLeavesBloc(
    get<_i12.UserLeaveService>(),
    get<_i21.UserManager>(),
  ));
  gh.factory<_i26.AdminPaidLeaveCountBloc>(() => _i26.AdminPaidLeaveCountBloc(
        get<_i10.PaidLeaveService>(),
        get<_i24.NavigationStackManager>(),
      ));
  gh.factory<_i27.LogOutBloc>(() => _i27.LogOutBloc(
        get<_i23.LoginState>(),
        get<_i13.UserPreference>(),
      ));
  return get;
}

class _$AppModule extends _i28.AppModule {}
