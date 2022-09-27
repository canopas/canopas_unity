// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i14;

import '../bloc/admin/employee/employee_detail_bloc.dart' as _i20;
import '../bloc/admin/employee/employee_list_bloc.dart' as _i21;
import '../bloc/admin/employee/employee_validation.dart' as _i7;
import '../bloc/admin/employees_summary/employees_summary_bloc.dart' as _i8;
import '../bloc/admin/leave/absence_bloc.dart' as _i17;
import '../bloc/admin/leave/leave_application_bloc.dart' as _i9;
import '../bloc/admin/leave_count/all_leave_count.dart' as _i3;
import '../bloc/admin/leave_details_screen/admin_leave_details_bloc.dart'
    as _i18;
import '../bloc/authentication/login_bloc.dart' as _i22;
import '../bloc/authentication/logout_bloc.dart' as _i28;
import '../bloc/employee/employee_leave_count/employee_home_bloc.dart' as _i24;
import '../bloc/network/network_service_bloc.dart' as _i12;
import '../bloc/user/user_leave_bloc.dart' as _i27;
import '../navigation/navigation_stack_manager.dart' as _i26;
import '../pref/user_preference.dart' as _i16;
import '../provider/user_data.dart' as _i23;
import '../services/auth/auth_service.dart' as _i5;
import '../services/employee/employee_service.dart' as _i6;
import '../services/leave/admin_leave_service.dart' as _i4;
import '../services/leave/paid_leave_service.dart' as _i13;
import '../services/leave/user_leave_service.dart' as _i15;
import '../stateManager/admin/leave_status_manager.dart' as _i11;
import '../stateManager/auth/auth_manager.dart' as _i19;
import '../stateManager/login_state_manager.dart' as _i25;
import '../stateManager/user/leave_request_data_manager.dart' as _i10;
import 'AppModule.dart' as _i29; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i3.AdminLeaveCount>(_i3.AdminLeaveCount());
  gh.factory<_i4.AdminLeaveService>(() => _i4.AdminLeaveService());
  gh.singleton<_i5.AuthService>(_i5.AuthService());
  gh.singleton<_i6.EmployeeService>(_i6.EmployeeService());
  gh.singleton<_i7.EmployeeValidationBloc>(_i7.EmployeeValidationBloc());
  gh.factory<_i8.EmployeesSummaryBloc>(() => _i8.EmployeesSummaryBloc(
        get<_i4.AdminLeaveService>(),
        get<_i6.EmployeeService>(),
      ));
  gh.singleton<_i9.LeaveApplicationBloc>(_i9.LeaveApplicationBloc(
    get<_i6.EmployeeService>(),
    get<_i4.AdminLeaveService>(),
  ));
  gh.singleton<_i10.LeaveRequestDataManager>(_i10.LeaveRequestDataManager());
  gh.singleton<_i11.LeaveStatusManager>(_i11.LeaveStatusManager(
    get<_i4.AdminLeaveService>(),
    get<_i9.LeaveApplicationBloc>(),
  ));
  gh.singleton<_i12.NetworkServiceBloc>(_i12.NetworkServiceBloc());
  gh.singleton<_i13.PaidLeaveService>(_i13.PaidLeaveService());
  await gh.factoryAsync<_i14.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.singleton<_i15.UserLeaveService>(_i15.UserLeaveService());
  gh.factory<_i16.UserPreference>(
      () => _i16.UserPreference(get<_i14.SharedPreferences>()));
  gh.singleton<_i17.AbsenceBloc>(_i17.AbsenceBloc(
    get<_i6.EmployeeService>(),
    get<_i4.AdminLeaveService>(),
  ));
  gh.singleton<_i18.AdminLeaveDetailsScreenBloc>(
      _i18.AdminLeaveDetailsScreenBloc(
    get<_i15.UserLeaveService>(),
    get<_i13.PaidLeaveService>(),
  ));
  gh.singleton<_i19.AuthManager>(_i19.AuthManager(
    get<_i16.UserPreference>(),
    get<_i5.AuthService>(),
  ));
  gh.singleton<_i20.EmployeeDetailBloc>(
      _i20.EmployeeDetailBloc(get<_i6.EmployeeService>()));
  gh.singleton<_i21.EmployeeListBloc>(
      _i21.EmployeeListBloc(get<_i6.EmployeeService>()));
  gh.singleton<_i22.LoginBloc>(_i22.LoginBloc(get<_i19.AuthManager>()));
  gh.singleton<_i23.UserManager>(_i23.UserManager(get<_i16.UserPreference>()));
  gh.factory<_i24.EmployeeHomeBLoc>(() => _i24.EmployeeHomeBLoc(
        get<_i23.UserManager>(),
        get<_i15.UserLeaveService>(),
        get<_i13.PaidLeaveService>(),
      ));
  gh.singleton<_i25.LoginState>(_i25.LoginState(get<_i23.UserManager>()));
  gh.lazySingleton<_i26.NavigationStackManager>(
    () => _i26.NavigationStackManager(get<_i23.UserManager>()),
    dispose: (i) => i.dispose(),
  );
  gh.singleton<_i27.UserLeavesBloc>(_i27.UserLeavesBloc(
    get<_i15.UserLeaveService>(),
    get<_i23.UserManager>(),
  ));
  gh.factory<_i28.LogOutBloc>(() => _i28.LogOutBloc(
        get<_i25.LoginState>(),
        get<_i16.UserPreference>(),
      ));
  return get;
}

class _$AppModule extends _i29.AppModule {}
