// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/bloc/authentication/logout_bloc.dart' as _i38;
import 'package:projectunity/bloc/network/network_connection_bloc.dart' as _i11;
import 'package:projectunity/di/app_module.dart' as _i44;
import 'package:projectunity/pref/user_preference.dart' as _i15;
import 'package:projectunity/provider/user_data.dart' as _i30;
import 'package:projectunity/router/app_router.dart' as _i33;
import 'package:projectunity/services/admin/employee_service.dart' as _i7;
import 'package:projectunity/services/admin/leave_service.dart' as _i3;
import 'package:projectunity/services/admin/paid_leave_service.dart' as _i12;
import 'package:projectunity/services/auth/auth_service.dart' as _i25;
import 'package:projectunity/services/user/user_leave_service.dart' as _i14;
import 'package:projectunity/stateManager/auth/auth_manager.dart' as _i35;
import 'package:projectunity/stateManager/auth/desktop/desktop_auth_manager.dart'
    as _i6;
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_bloc.dart'
    as _i36;
import 'package:projectunity/ui/admin/employee/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i19;
import 'package:projectunity/ui/admin/employee/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i17;
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_bloc.dart'
    as _i26;
import 'package:projectunity/ui/admin/home/addmember/bloc/add_member_bloc.dart'
    as _i16;
import 'package:projectunity/ui/admin/home/application_detail/bloc/admin_leave_application_detail_bloc.dart'
    as _i21;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i20;
import 'package:projectunity/ui/admin/leaves/detail/bloc/admin_leave_detail_bloc.dart'
    as _i22;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i23;
import 'package:projectunity/ui/admin/setting/bloc/admin_settings_bloc.dart'
    as _i32;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i24;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i4;
import 'package:projectunity/ui/login/bloc/login_view_bloc.dart' as _i39;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i8;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i36;
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart'
    as _i27;
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_bloc.dart'
    as _i40;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i41;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i9;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i28;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i34;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i29;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i43;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i42;
import 'package:projectunity/ui/user/settings/edit_profile/bloc/emloyee_edit_profile_bloc.dart'
    as _i37;
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_bloc.dart'
    as _i31;
import 'package:projectunity/widget/WhoIsOutCard/bloc/who_is_out_card_bloc.dart'
    as _i15;
import 'package:shared_preferences/shared_preferences.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
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
    gh.factory<_i5.Connectivity>(() => appModule.connectivity);
    gh.factory<_i6.DesktopAuthManager>(() => _i6.DesktopAuthManager());
    gh.singleton<_i7.EmployeeService>(
      _i7.EmployeeService(),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i8.EmployeesCalenderBloc>(() => _i8.EmployeesCalenderBloc());
    gh.factory<_i9.LeaveCalendarBloc>(() => _i9.LeaveCalendarBloc());
    gh.factory<_i10.NetworkConnectionBloc>(
        () => _i10.NetworkConnectionBloc(gh<_i5.Connectivity>()));
    gh.singleton<_i11.PaidLeaveService>(_i11.PaidLeaveService());
    await gh.factoryAsync<_i12.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.singleton<_i13.UserLeaveService>(_i13.UserLeaveService());
    gh.singleton<_i14.UserPreference>(
        _i14.UserPreference(gh<_i12.SharedPreferences>()));
    gh.factory<_i15.WhoIsOutCardBloc>(() => _i15.WhoIsOutCardBloc(
          gh<_i7.EmployeeService>(),
          gh<_i3.AdminLeaveService>(),
        ));
    gh.factory<_i17.AddMemberBloc>(
        () => _i17.AddMemberBloc(gh<_i7.EmployeeService>()));
    gh.factory<_i18.AdminEditEmployeeDetailsBloc>(
        () => _i18.AdminEditEmployeeDetailsBloc(gh<_i7.EmployeeService>()));
    gh.factory<_i19.AdminEmployeeDetailsLeavesBLoc>(
        () => _i19.AdminEmployeeDetailsLeavesBLoc(gh<_i14.UserLeaveService>()));
    gh.factory<_i20.AdminHomeBloc>(() => _i20.AdminHomeBloc(
          gh<_i3.AdminLeaveService>(),
          gh<_i7.EmployeeService>(),
        ));
    gh.factory<_i21.AdminLeaveApplicationDetailsBloc>(
        () => _i21.AdminLeaveApplicationDetailsBloc(
              gh<_i14.UserLeaveService>(),
              gh<_i3.AdminLeaveService>(),
              gh<_i11.PaidLeaveService>(),
            ));
    gh.factory<_i22.AdminLeaveDetailBloc>(() => _i22.AdminLeaveDetailBloc(
          gh<_i14.UserLeaveService>(),
          gh<_i12.PaidLeaveService>(),
        ));
    gh.factory<_i23.AdminLeavesBloc>(() => _i23.AdminLeavesBloc(
          gh<_i3.AdminLeaveService>(),
          gh<_i7.EmployeeService>(),
        ));
    gh.factory<_i24.AdminSettingUpdatePaidLeaveCountBloc>(() =>
        _i24.AdminSettingUpdatePaidLeaveCountBloc(gh<_i12.PaidLeaveService>()));
    gh.singleton<_i25.AuthService>(_i25.AuthService(
      gh<_i6.DesktopAuthManager>(),
      gh<_i14.UserPreference>(),
    ));
    gh.factory<_i26.EmployeeListBloc>(
        () => _i26.EmployeeListBloc(gh<_i7.EmployeeService>()));
    gh.factory<_i27.UserEmployeeDetailBloc>(() => _i27.UserEmployeeDetailBloc(
          gh<_i7.EmployeeService>(),
          gh<_i13.UserLeaveService>(),
        ));
    gh.factory<_i28.UserLeaveCalendarBloc>(() => _i28.UserLeaveCalendarBloc(
          gh<_i14.UserLeaveService>(),
          gh<_i7.EmployeeService>(),
          gh<_i12.PaidLeaveService>(),
        ));
    gh.factory<_i29.UserLeaveDetailBloc>(
        () => _i29.UserLeaveDetailBloc(gh<_i14.UserLeaveService>()));
    gh.singleton<_i30.UserManager>(_i30.UserManager(gh<_i15.UserPreference>()));
    gh.factory<_i31.UserSettingsBloc>(() => _i31.UserSettingsBloc(
          gh<_i30.UserManager>(),
          gh<_i25.AuthService>(),
          gh<_i15.UserPreference>(),
        ));
    gh.factory<_i32.AdminSettingsBloc>(() => _i32.AdminSettingsBloc(
          gh<_i30.UserManager>(),
          gh<_i25.AuthService>(),
          gh<_i15.UserPreference>(),
        ));
    gh.factory<_i33.AppRouter>(() => _i33.AppRouter(gh<_i30.UserManager>()));
    gh.factory<_i34.ApplyLeaveBloc>(() => _i34.ApplyLeaveBloc(
          gh<_i30.UserManager>(),
          gh<_i12.PaidLeaveService>(),
          gh<_i14.UserLeaveService>(),
        ));
    gh.singleton<_i35.AuthManager>(_i35.AuthManager(
      gh<_i15.UserPreference>(),
      gh<_i25.AuthService>(),
    ));
    gh.factory<_i36.EmployeeDetailBloc>(() => _i36.EmployeeDetailBloc(
          gh<_i12.PaidLeaveService>(),
          gh<_i7.EmployeeService>(),
          gh<_i14.UserLeaveService>(),
          gh<_i30.UserManager>(),
        ));
    gh.factory<_i37.EmployeeEditProfileBloc>(() => _i37.EmployeeEditProfileBloc(
          gh<_i7.EmployeeService>(),
          gh<_i15.UserPreference>(),
          gh<_i30.UserManager>(),
        ));
    gh.factory<_i38.LogOutBloc>(() => _i38.LogOutBloc(
          gh<_i15.UserPreference>(),
          gh<_i25.AuthService>(),
          gh<_i30.UserManager>(),
        ));
    gh.factory<_i39.LoginBloc>(() => _i39.LoginBloc(
          gh<_i35.AuthManager>(),
          gh<_i30.UserManager>(),
          gh<_i25.AuthService>(),
        ));
    gh.factory<_i40.UserEmployeesBloc>(() => _i40.UserEmployeesBloc(
          gh<_i7.EmployeeService>(),
          gh<_i30.UserManager>(),
        ));
    gh.factory<_i41.UserHomeBloc>(() => _i41.UserHomeBloc(
          gh<_i15.UserPreference>(),
          gh<_i25.AuthService>(),
          gh<_i30.UserManager>(),
          gh<_i14.UserLeaveService>(),
        ));
    gh.factory<_i42.UserLeaveBloc>(() => _i42.UserLeaveBloc(
          gh<_i30.UserManager>(),
          gh<_i14.UserLeaveService>(),
        ));
    gh.factory<_i43.UserLeaveCountBloc>(() => _i43.UserLeaveCountBloc(
          gh<_i14.UserLeaveService>(),
          gh<_i30.UserManager>(),
          gh<_i12.PaidLeaveService>(),
        ));
    return this;
  }
}

class _$AppModule extends _i44.AppModule {}
