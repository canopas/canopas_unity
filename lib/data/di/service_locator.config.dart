// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart'
    as _i12;
import 'package:projectunity/data/di/app_module.dart' as _i44;
import 'package:projectunity/data/pref/user_preference.dart' as _i18;
import 'package:projectunity/data/provider/user_data.dart' as _i30;
import 'package:projectunity/data/services/auth_service.dart' as _i27;
import 'package:projectunity/data/services/employee_service.dart' as _i8;
import 'package:projectunity/data/services/leave_service.dart' as _i11;
import 'package:projectunity/data/services/paid_leave_service.dart' as _i13;
import 'package:projectunity/data/stateManager/auth/auth_manager.dart' as _i36;
import 'package:projectunity/data/stateManager/auth/desktop/desktop_auth_manager.dart'
    as _i6;
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_bloc.dart'
    as _i28;
import 'package:projectunity/ui/admin/employee/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i22;
import 'package:projectunity/ui/admin/employee/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i21;
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_bloc.dart'
    as _i29;
import 'package:projectunity/ui/admin/home/addmember/bloc/add_member_bloc.dart'
    as _i20;
import 'package:projectunity/ui/admin/home/application_detail/bloc/admin_leave_application_detail_bloc.dart'
    as _i24;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i23;
import 'package:projectunity/ui/admin/leaves/detail/bloc/admin_leave_detail_bloc.dart'
    as _i25;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i32;
import 'package:projectunity/ui/admin/setting/bloc/admin_settings_bloc.dart'
    as _i33;
import 'package:projectunity/ui/admin/setting/edit_work_space/bloc/edit_workspace_bloc.dart'
    as _i7;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i26;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i3;
import 'package:projectunity/ui/navigation/app_router.dart' as _i34;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i9;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i38;
import 'package:projectunity/ui/shared/WhoIsOutCard/bloc/who_is_out_card_bloc.dart'
    as _i19;
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart' as _i39;
import 'package:projectunity/ui/sign_in/create_workspace/bloc/create_workspace_bloc.dart'
    as _i5;
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart'
    as _i15;
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_bloc.dart'
    as _i40;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i41;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i10;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i16;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i35;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i17;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i43;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i42;
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_bloc.dart'
    as _i37;
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_bloc.dart'
    as _i31;
import 'package:shared_preferences/shared_preferences.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

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
    gh.factory<_i3.AdminPaidLeaveUpdateSettingTextFieldBloc>(
        () => _i3.AdminPaidLeaveUpdateSettingTextFieldBloc());
    gh.factory<_i4.Connectivity>(() => appModule.connectivity);
    gh.factory<_i5.CreateWorkSpaceBLoc>(() => _i5.CreateWorkSpaceBLoc());
    gh.factory<_i6.DesktopAuthManager>(() => _i6.DesktopAuthManager());
    gh.factory<_i7.EditWorkSpaceBloc>(() => _i7.EditWorkSpaceBloc());
    gh.singleton<_i8.EmployeeService>(
      _i8.EmployeeService(),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i9.EmployeesCalenderBloc>(() => _i9.EmployeesCalenderBloc());
    gh.factory<_i10.LeaveCalendarBloc>(() => _i10.LeaveCalendarBloc());
    gh.singleton<_i11.LeaveService>(
      _i11.LeaveService(),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i12.NetworkConnectionBloc>(
        () => _i12.NetworkConnectionBloc(gh<_i4.Connectivity>()));
    gh.singleton<_i13.PaidLeaveService>(_i13.PaidLeaveService());
    await gh.factoryAsync<_i14.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.factory<_i15.UserEmployeeDetailBloc>(() => _i15.UserEmployeeDetailBloc(
          gh<_i8.EmployeeService>(),
          gh<_i11.LeaveService>(),
        ));
    gh.factory<_i16.UserLeaveCalendarBloc>(() => _i16.UserLeaveCalendarBloc(
          gh<_i11.LeaveService>(),
          gh<_i8.EmployeeService>(),
          gh<_i13.PaidLeaveService>(),
        ));
    gh.factory<_i17.UserLeaveDetailBloc>(
        () => _i17.UserLeaveDetailBloc(gh<_i11.LeaveService>()));
    gh.singleton<_i18.UserPreference>(
        _i18.UserPreference(gh<_i14.SharedPreferences>()));
    gh.factory<_i19.WhoIsOutCardBloc>(() => _i19.WhoIsOutCardBloc(
          gh<_i8.EmployeeService>(),
          gh<_i11.LeaveService>(),
        ));
    gh.factory<_i20.AddMemberBloc>(
        () => _i20.AddMemberBloc(gh<_i8.EmployeeService>()));
    gh.factory<_i21.AdminEditEmployeeDetailsBloc>(
        () => _i21.AdminEditEmployeeDetailsBloc(gh<_i8.EmployeeService>()));
    gh.factory<_i22.AdminEmployeeDetailsLeavesBLoc>(
        () => _i22.AdminEmployeeDetailsLeavesBLoc(gh<_i11.LeaveService>()));
    gh.factory<_i23.AdminHomeBloc>(() => _i23.AdminHomeBloc(
          gh<_i11.LeaveService>(),
          gh<_i8.EmployeeService>(),
        ));
    gh.factory<_i24.AdminLeaveApplicationDetailsBloc>(
        () => _i24.AdminLeaveApplicationDetailsBloc(
              gh<_i11.LeaveService>(),
              gh<_i13.PaidLeaveService>(),
            ));
    gh.factory<_i25.AdminLeaveDetailBloc>(() => _i25.AdminLeaveDetailBloc(
          gh<_i11.LeaveService>(),
          gh<_i13.PaidLeaveService>(),
        ));
    gh.factory<_i26.AdminSettingUpdatePaidLeaveCountBloc>(() =>
        _i26.AdminSettingUpdatePaidLeaveCountBloc(gh<_i13.PaidLeaveService>()));
    gh.singleton<_i27.AuthService>(_i27.AuthService(
      gh<_i6.DesktopAuthManager>(),
      gh<_i18.UserPreference>(),
    ));
    gh.factory<_i28.EmployeeDetailBloc>(() => _i28.EmployeeDetailBloc(
          gh<_i13.PaidLeaveService>(),
          gh<_i8.EmployeeService>(),
          gh<_i11.LeaveService>(),
        ));
    gh.factory<_i29.EmployeeListBloc>(
        () => _i29.EmployeeListBloc(gh<_i8.EmployeeService>()));
    gh.singleton<_i30.UserManager>(_i30.UserManager(gh<_i18.UserPreference>()));
    gh.factory<_i31.UserSettingsBloc>(() => _i31.UserSettingsBloc(
          gh<_i30.UserManager>(),
          gh<_i27.AuthService>(),
          gh<_i18.UserPreference>(),
        ));
    gh.factory<_i32.AdminLeavesBloc>(() => _i32.AdminLeavesBloc(
          gh<_i11.LeaveService>(),
          gh<_i8.EmployeeService>(),
          gh<_i30.UserManager>(),
        ));
    gh.factory<_i33.AdminSettingsBloc>(() => _i33.AdminSettingsBloc(
          gh<_i30.UserManager>(),
          gh<_i27.AuthService>(),
          gh<_i18.UserPreference>(),
        ));
    gh.factory<_i34.AppRouter>(() => _i34.AppRouter(gh<_i30.UserManager>()));
    gh.factory<_i35.ApplyLeaveBloc>(() => _i35.ApplyLeaveBloc(
          gh<_i30.UserManager>(),
          gh<_i11.LeaveService>(),
        ));
    gh.singleton<_i36.AuthManager>(_i36.AuthManager(
      gh<_i18.UserPreference>(),
      gh<_i27.AuthService>(),
    ));
    gh.factory<_i37.EmployeeEditProfileBloc>(() => _i37.EmployeeEditProfileBloc(
          gh<_i8.EmployeeService>(),
          gh<_i18.UserPreference>(),
          gh<_i30.UserManager>(),
        ));
    gh.factory<_i38.EmployeesCalendarLeavesBloc>(
        () => _i38.EmployeesCalendarLeavesBloc(
              gh<_i8.EmployeeService>(),
              gh<_i11.LeaveService>(),
              gh<_i30.UserManager>(),
            ));
    gh.factory<_i39.SignInBloc>(() => _i39.SignInBloc(
          gh<_i36.AuthManager>(),
          gh<_i30.UserManager>(),
          gh<_i27.AuthService>(),
        ));
    gh.factory<_i40.UserEmployeesBloc>(() => _i40.UserEmployeesBloc(
          gh<_i8.EmployeeService>(),
          gh<_i30.UserManager>(),
        ));
    gh.factory<_i41.UserHomeBloc>(() => _i41.UserHomeBloc(
          gh<_i18.UserPreference>(),
          gh<_i27.AuthService>(),
          gh<_i30.UserManager>(),
          gh<_i11.LeaveService>(),
        ));
    gh.factory<_i42.UserLeaveBloc>(() => _i42.UserLeaveBloc(
          gh<_i30.UserManager>(),
          gh<_i11.LeaveService>(),
        ));
    gh.factory<_i43.UserLeaveCountBloc>(() => _i43.UserLeaveCountBloc(
          gh<_i11.LeaveService>(),
          gh<_i30.UserManager>(),
          gh<_i13.PaidLeaveService>(),
        ));
    return this;
  }
}

class _$AppModule extends _i44.AppModule {}
