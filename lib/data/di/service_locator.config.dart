// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:firebase_storage/firebase_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart'
    as _i10;
import 'package:projectunity/data/di/app_module.dart' as _i48;
import 'package:projectunity/data/pref/user_preference.dart' as _i14;
import 'package:projectunity/data/provider/user_data.dart' as _i16;
import 'package:projectunity/data/services/auth_service.dart' as _i15;
import 'package:projectunity/data/services/employee_service.dart' as _i22;
import 'package:projectunity/data/services/leave_service.dart' as _i24;
import 'package:projectunity/data/services/space_service.dart' as _i12;
import 'package:projectunity/data/services/storage_service.dart' as _i13;
import 'package:projectunity/data/state_manager/auth/desktop/desktop_auth_manager.dart'
    as _i5;
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_bloc.dart'
    as _i44;
import 'package:projectunity/ui/admin/employee/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i36;
import 'package:projectunity/ui/admin/employee/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i35;
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_bloc.dart'
    as _i46;
import 'package:projectunity/ui/admin/home/addmember/bloc/add_member_bloc.dart'
    as _i34;
import 'package:projectunity/ui/admin/home/application_detail/bloc/admin_leave_application_detail_bloc.dart'
    as _i38;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i37;
import 'package:projectunity/ui/admin/leaves/detail/bloc/admin_leave_detail_bloc.dart'
    as _i39;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i40;
import 'package:projectunity/ui/admin/setting/bloc/admin_settings_bloc.dart'
    as _i19;
import 'package:projectunity/ui/admin/setting/edit_space/bloc/edit_space_bloc.dart'
    as _i21;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i18;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i3;
import 'package:projectunity/ui/navigation/app_router.dart' as _i20;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i6;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i47;
import 'package:projectunity/ui/shared/WhoIsOutCard/bloc/who_is_out_card_bloc.dart'
    as _i33;
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart' as _i25;
import 'package:projectunity/ui/space/change_space_sheet/bloc/change_space_bloc.dart'
    as _i42;
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart'
    as _i43;
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart'
    as _i23;
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart'
    as _i26;
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_bloc.dart'
    as _i27;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i28;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i9;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i30;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i41;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i32;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i31;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i29;
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_bloc.dart'
    as _i45;
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_bloc.dart'
    as _i17;
import 'package:shared_preferences/shared_preferences.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

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
    gh.lazySingleton<_i4.Connectivity>(() => appModule.connectivity);
    gh.factory<_i5.DesktopAuthManager>(() => _i5.DesktopAuthManager());
    gh.factory<_i6.EmployeesCalenderBloc>(() => _i6.EmployeesCalenderBloc());
    gh.lazySingleton<_i7.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.factory<_i8.ImagePicker>(() => appModule.imagePicker);
    gh.factory<_i9.LeaveCalendarBloc>(() => _i9.LeaveCalendarBloc());
    gh.factory<_i10.NetworkConnectionBloc>(
        () => _i10.NetworkConnectionBloc(gh<_i4.Connectivity>()));
    await gh.factoryAsync<_i11.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i12.SpaceService>(() => _i12.SpaceService());
    gh.lazySingleton<_i13.StorageService>(
        () => _i13.StorageService(gh<_i7.FirebaseStorage>()));
    gh.singleton<_i14.UserPreference>(
        _i14.UserPreference(gh<_i11.SharedPreferences>()));
    gh.singleton<_i15.AuthService>(
        _i15.AuthService(gh<_i5.DesktopAuthManager>()));
    gh.singleton<_i16.UserManager>(_i16.UserManager(gh<_i14.UserPreference>()));
    gh.factory<_i17.UserSettingsBloc>(() => _i17.UserSettingsBloc(
          gh<_i16.UserManager>(),
          gh<_i15.AuthService>(),
        ));
    gh.factory<_i18.AdminSettingUpdatePaidLeaveCountBloc>(
        () => _i18.AdminSettingUpdatePaidLeaveCountBloc(
              gh<_i12.SpaceService>(),
              gh<_i16.UserManager>(),
            ));
    gh.factory<_i19.AdminSettingsBloc>(() => _i19.AdminSettingsBloc(
          gh<_i16.UserManager>(),
          gh<_i15.AuthService>(),
        ));
    gh.factory<_i20.AppRouter>(() => _i20.AppRouter(gh<_i16.UserManager>()));
    gh.factory<_i21.EditSpaceBloc>(() => _i21.EditSpaceBloc(
          gh<_i12.SpaceService>(),
          gh<_i16.UserManager>(),
        ));
    gh.lazySingleton<_i22.EmployeeService>(
        () => _i22.EmployeeService(gh<_i16.UserManager>()));
    gh.factory<_i23.JoinSpaceBloc>(() => _i23.JoinSpaceBloc(
          gh<_i12.SpaceService>(),
          gh<_i16.UserManager>(),
          gh<_i22.EmployeeService>(),
        ));
    gh.singleton<_i24.LeaveService>(_i24.LeaveService(gh<_i16.UserManager>()));
    gh.factory<_i25.SignInBloc>(() => _i25.SignInBloc(
          gh<_i16.UserManager>(),
          gh<_i15.AuthService>(),
        ));
    gh.factory<_i26.UserEmployeeDetailBloc>(() => _i26.UserEmployeeDetailBloc(
          gh<_i22.EmployeeService>(),
          gh<_i24.LeaveService>(),
        ));
    gh.factory<_i27.UserEmployeesBloc>(() => _i27.UserEmployeesBloc(
          gh<_i22.EmployeeService>(),
          gh<_i16.UserManager>(),
        ));
    gh.factory<_i28.UserHomeBloc>(() => _i28.UserHomeBloc(
          gh<_i15.AuthService>(),
          gh<_i16.UserManager>(),
          gh<_i24.LeaveService>(),
        ));
    gh.factory<_i29.UserLeaveBloc>(() => _i29.UserLeaveBloc(
          gh<_i16.UserManager>(),
          gh<_i24.LeaveService>(),
        ));
    gh.factory<_i30.UserLeaveCalendarBloc>(() => _i30.UserLeaveCalendarBloc(
          gh<_i24.LeaveService>(),
          gh<_i22.EmployeeService>(),
          gh<_i16.UserManager>(),
          gh<_i12.SpaceService>(),
        ));
    gh.factory<_i31.UserLeaveCountBloc>(() => _i31.UserLeaveCountBloc(
          gh<_i24.LeaveService>(),
          gh<_i16.UserManager>(),
          gh<_i12.SpaceService>(),
        ));
    gh.factory<_i32.UserLeaveDetailBloc>(
        () => _i32.UserLeaveDetailBloc(gh<_i24.LeaveService>()));
    gh.factory<_i33.WhoIsOutCardBloc>(() => _i33.WhoIsOutCardBloc(
          gh<_i22.EmployeeService>(),
          gh<_i24.LeaveService>(),
        ));
    gh.factory<_i34.AddMemberBloc>(
        () => _i34.AddMemberBloc(gh<_i22.EmployeeService>()));
    gh.factory<_i35.AdminEditEmployeeDetailsBloc>(
        () => _i35.AdminEditEmployeeDetailsBloc(gh<_i22.EmployeeService>()));
    gh.factory<_i36.AdminEmployeeDetailsLeavesBLoc>(
        () => _i36.AdminEmployeeDetailsLeavesBLoc(gh<_i24.LeaveService>()));
    gh.factory<_i37.AdminHomeBloc>(() => _i37.AdminHomeBloc(
          gh<_i24.LeaveService>(),
          gh<_i22.EmployeeService>(),
          gh<_i16.UserManager>(),
        ));
    gh.factory<_i38.AdminLeaveApplicationDetailsBloc>(
        () => _i38.AdminLeaveApplicationDetailsBloc(
              gh<_i24.LeaveService>(),
              gh<_i16.UserManager>(),
              gh<_i12.SpaceService>(),
            ));
    gh.factory<_i39.AdminLeaveDetailBloc>(() => _i39.AdminLeaveDetailBloc(
          gh<_i24.LeaveService>(),
          gh<_i16.UserManager>(),
          gh<_i12.SpaceService>(),
        ));
    gh.factory<_i40.AdminLeavesBloc>(() => _i40.AdminLeavesBloc(
          gh<_i24.LeaveService>(),
          gh<_i22.EmployeeService>(),
          gh<_i16.UserManager>(),
        ));
    gh.factory<_i41.ApplyLeaveBloc>(() => _i41.ApplyLeaveBloc(
          gh<_i16.UserManager>(),
          gh<_i24.LeaveService>(),
        ));
    gh.factory<_i42.ChangeSpaceBloc>(() => _i42.ChangeSpaceBloc(
          gh<_i16.UserManager>(),
          gh<_i12.SpaceService>(),
          gh<_i22.EmployeeService>(),
        ));
    gh.factory<_i43.CreateSpaceBLoc>(() => _i43.CreateSpaceBLoc(
          gh<_i12.SpaceService>(),
          gh<_i16.UserManager>(),
          gh<_i22.EmployeeService>(),
        ));
    gh.factory<_i44.EmployeeDetailBloc>(() => _i44.EmployeeDetailBloc(
          gh<_i12.SpaceService>(),
          gh<_i16.UserManager>(),
          gh<_i22.EmployeeService>(),
          gh<_i24.LeaveService>(),
        ));
    gh.factory<_i45.EmployeeEditProfileBloc>(() => _i45.EmployeeEditProfileBloc(
          gh<_i22.EmployeeService>(),
          gh<_i14.UserPreference>(),
          gh<_i16.UserManager>(),
          gh<_i13.StorageService>(),
          gh<_i8.ImagePicker>(),
        ));
    gh.factory<_i46.EmployeeListBloc>(
        () => _i46.EmployeeListBloc(gh<_i22.EmployeeService>()));
    gh.factory<_i47.EmployeesCalendarLeavesBloc>(
        () => _i47.EmployeesCalendarLeavesBloc(
              gh<_i22.EmployeeService>(),
              gh<_i24.LeaveService>(),
              gh<_i16.UserManager>(),
            ));
    return this;
  }
}

class _$AppModule extends _i48.AppModule {}
