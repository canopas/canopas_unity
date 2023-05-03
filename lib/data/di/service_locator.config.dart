// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i10;
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:device_info_plus/device_info_plus.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i9;
import 'package:firebase_storage/firebase_storage.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i12;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart'
    as _i15;
import 'package:projectunity/data/di/app_module.dart' as _i55;
import 'package:projectunity/data/pref/user_preference.dart' as _i19;
import 'package:projectunity/data/provider/device_info.dart' as _i7;
import 'package:projectunity/data/provider/user_data.dart' as _i22;
import 'package:projectunity/data/services/account_service.dart' as _i20;
import 'package:projectunity/data/services/auth_service.dart' as _i21;
import 'package:projectunity/data/services/employee_service.dart' as _i28;
import 'package:projectunity/data/services/invitation_services.dart' as _i13;
import 'package:projectunity/data/services/leave_service.dart' as _i31;
import 'package:projectunity/data/services/space_service.dart' as _i17;
import 'package:projectunity/data/services/storage_service.dart' as _i18;
import 'package:projectunity/data/state_manager/auth/desktop/desktop_auth_manager.dart'
    as _i5;
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_bloc.dart'
    as _i51;
import 'package:projectunity/ui/admin/employee/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i43;
import 'package:projectunity/ui/admin/employee/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i42;
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_bloc.dart'
    as _i53;
import 'package:projectunity/ui/admin/home/addmember/bloc/add_member_bloc.dart'
    as _i41;
import 'package:projectunity/ui/admin/home/application_detail/bloc/admin_leave_application_detail_bloc.dart'
    as _i45;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i44;
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_bloc.dart'
    as _i29;
import 'package:projectunity/ui/admin/leaves/detail/bloc/admin_leave_detail_bloc.dart'
    as _i46;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i47;
import 'package:projectunity/ui/admin/setting/edit_space/bloc/edit_space_bloc.dart'
    as _i27;
import 'package:projectunity/ui/admin/setting/settings_screen/bloc/admin_settings_bloc.dart'
    as _i25;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i24;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i3;
import 'package:projectunity/ui/navigation/app_router.dart' as _i26;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i8;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i54;
import 'package:projectunity/ui/shared/WhoIsOutCard/bloc/who_is_out_card_bloc.dart'
    as _i40;
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart' as _i32;
import 'package:projectunity/ui/space/change_space_sheet/bloc/change_space_bloc.dart'
    as _i49;
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart'
    as _i50;
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart'
    as _i30;
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart'
    as _i33;
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_bloc.dart'
    as _i34;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i35;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i14;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i37;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i48;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i39;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i38;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i36;
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_bloc.dart'
    as _i52;
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_bloc.dart'
    as _i23;
import 'package:shared_preferences/shared_preferences.dart' as _i16;

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
    gh.factory<_i5.DesktopAuthManager>(() => _i5.DesktopAuthManager());
    gh.factory<_i6.DeviceInfoPlugin>(() => appModule.deviceInfoPlugin);
    gh.factory<_i7.DeviceInfoProvider>(
        () => _i7.DeviceInfoProvider(gh<_i6.DeviceInfoPlugin>()));
    gh.factory<_i8.EmployeesCalenderBloc>(() => _i8.EmployeesCalenderBloc());
    gh.factory<_i9.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i10.FirebaseFirestore>(() => appModule.firebaseFireStore);
    gh.factory<_i11.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.factory<_i12.ImagePicker>(() => appModule.imagePicker);
    gh.lazySingleton<_i13.InvitationService>(
        () => _i13.InvitationService(gh<_i10.FirebaseFirestore>()));
    gh.factory<_i14.LeaveCalendarBloc>(() => _i14.LeaveCalendarBloc());
    gh.factory<_i15.NetworkConnectionBloc>(
        () => _i15.NetworkConnectionBloc(gh<_i4.Connectivity>()));
    await gh.factoryAsync<_i16.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i17.SpaceService>(
        () => _i17.SpaceService(gh<_i10.FirebaseFirestore>()));
    gh.lazySingleton<_i18.StorageService>(
        () => _i18.StorageService(gh<_i11.FirebaseStorage>()));
    gh.singleton<_i19.UserPreference>(
        _i19.UserPreference(gh<_i16.SharedPreferences>()));
    gh.lazySingleton<_i20.AccountService>(() => _i20.AccountService(
          gh<_i10.FirebaseFirestore>(),
          gh<_i7.DeviceInfoProvider>(),
        ));
    gh.singleton<_i21.AuthService>(_i21.AuthService(
      gh<_i5.DesktopAuthManager>(),
      gh<_i10.FirebaseFirestore>(),
      gh<_i9.FirebaseAuth>(),
    ));
    gh.singleton<_i22.UserManager>(_i22.UserManager(gh<_i19.UserPreference>()));
    gh.factory<_i23.UserSettingsBloc>(() => _i23.UserSettingsBloc(
          gh<_i22.UserManager>(),
          gh<_i21.AuthService>(),
        ));
    gh.factory<_i24.AdminSettingUpdatePaidLeaveCountBloc>(
        () => _i24.AdminSettingUpdatePaidLeaveCountBloc(
              gh<_i17.SpaceService>(),
              gh<_i22.UserManager>(),
            ));
    gh.factory<_i25.AdminSettingsBloc>(() => _i25.AdminSettingsBloc(
          gh<_i22.UserManager>(),
          gh<_i21.AuthService>(),
        ));
    gh.factory<_i26.AppRouter>(() => _i26.AppRouter(gh<_i22.UserManager>()));
    gh.factory<_i27.EditSpaceBloc>(() => _i27.EditSpaceBloc(
          gh<_i17.SpaceService>(),
          gh<_i22.UserManager>(),
        ));
    gh.lazySingleton<_i28.EmployeeService>(() => _i28.EmployeeService(
          gh<_i22.UserManager>(),
          gh<_i10.FirebaseFirestore>(),
        ));
    gh.factory<_i29.InviteMemberBloc>(() => _i29.InviteMemberBloc(
          gh<_i13.InvitationService>(),
          gh<_i22.UserManager>(),
        ));
    gh.factory<_i30.JoinSpaceBloc>(() => _i30.JoinSpaceBloc(
          gh<_i13.InvitationService>(),
          gh<_i17.SpaceService>(),
          gh<_i22.UserManager>(),
          gh<_i20.AccountService>(),
          gh<_i28.EmployeeService>(),
        ));
    gh.lazySingleton<_i31.LeaveService>(() => _i31.LeaveService(
          gh<_i22.UserManager>(),
          gh<_i10.FirebaseFirestore>(),
        ));
    gh.factory<_i32.SignInBloc>(() => _i32.SignInBloc(
          gh<_i22.UserManager>(),
          gh<_i21.AuthService>(),
          gh<_i20.AccountService>(),
        ));
    gh.factory<_i33.UserEmployeeDetailBloc>(() => _i33.UserEmployeeDetailBloc(
          gh<_i28.EmployeeService>(),
          gh<_i31.LeaveService>(),
        ));
    gh.factory<_i34.UserEmployeesBloc>(() => _i34.UserEmployeesBloc(
          gh<_i28.EmployeeService>(),
          gh<_i22.UserManager>(),
        ));
    gh.factory<_i35.UserHomeBloc>(() => _i35.UserHomeBloc(
          gh<_i21.AuthService>(),
          gh<_i22.UserManager>(),
          gh<_i31.LeaveService>(),
        ));
    gh.factory<_i36.UserLeaveBloc>(() => _i36.UserLeaveBloc(
          gh<_i22.UserManager>(),
          gh<_i31.LeaveService>(),
        ));
    gh.factory<_i37.UserLeaveCalendarBloc>(() => _i37.UserLeaveCalendarBloc(
          gh<_i31.LeaveService>(),
          gh<_i28.EmployeeService>(),
          gh<_i22.UserManager>(),
          gh<_i17.SpaceService>(),
        ));
    gh.factory<_i38.UserLeaveCountBloc>(() => _i38.UserLeaveCountBloc(
          gh<_i31.LeaveService>(),
          gh<_i22.UserManager>(),
          gh<_i17.SpaceService>(),
        ));
    gh.factory<_i39.UserLeaveDetailBloc>(
        () => _i39.UserLeaveDetailBloc(gh<_i31.LeaveService>()));
    gh.factory<_i40.WhoIsOutCardBloc>(() => _i40.WhoIsOutCardBloc(
          gh<_i28.EmployeeService>(),
          gh<_i31.LeaveService>(),
        ));
    gh.factory<_i41.AddMemberBloc>(
        () => _i41.AddMemberBloc(gh<_i28.EmployeeService>()));
    gh.factory<_i42.AdminEditEmployeeDetailsBloc>(
        () => _i42.AdminEditEmployeeDetailsBloc(gh<_i28.EmployeeService>()));
    gh.factory<_i43.AdminEmployeeDetailsLeavesBLoc>(
        () => _i43.AdminEmployeeDetailsLeavesBLoc(gh<_i31.LeaveService>()));
    gh.factory<_i44.AdminHomeBloc>(() => _i44.AdminHomeBloc(
          gh<_i31.LeaveService>(),
          gh<_i28.EmployeeService>(),
          gh<_i22.UserManager>(),
        ));
    gh.factory<_i45.AdminLeaveApplicationDetailsBloc>(
        () => _i45.AdminLeaveApplicationDetailsBloc(
              gh<_i31.LeaveService>(),
              gh<_i22.UserManager>(),
              gh<_i17.SpaceService>(),
            ));
    gh.factory<_i46.AdminLeaveDetailBloc>(() => _i46.AdminLeaveDetailBloc(
          gh<_i31.LeaveService>(),
          gh<_i22.UserManager>(),
          gh<_i17.SpaceService>(),
        ));
    gh.factory<_i47.AdminLeavesBloc>(() => _i47.AdminLeavesBloc(
          gh<_i31.LeaveService>(),
          gh<_i28.EmployeeService>(),
        ));
    gh.factory<_i48.ApplyLeaveBloc>(() => _i48.ApplyLeaveBloc(
          gh<_i22.UserManager>(),
          gh<_i31.LeaveService>(),
        ));
    gh.factory<_i49.ChangeSpaceBloc>(() => _i49.ChangeSpaceBloc(
          gh<_i22.UserManager>(),
          gh<_i17.SpaceService>(),
          gh<_i28.EmployeeService>(),
        ));
    gh.factory<_i50.CreateSpaceBLoc>(() => _i50.CreateSpaceBLoc(
          gh<_i17.SpaceService>(),
          gh<_i22.UserManager>(),
          gh<_i28.EmployeeService>(),
        ));
    gh.factory<_i51.EmployeeDetailBloc>(() => _i51.EmployeeDetailBloc(
          gh<_i17.SpaceService>(),
          gh<_i22.UserManager>(),
          gh<_i28.EmployeeService>(),
          gh<_i31.LeaveService>(),
        ));
    gh.factory<_i52.EmployeeEditProfileBloc>(() => _i52.EmployeeEditProfileBloc(
          gh<_i28.EmployeeService>(),
          gh<_i19.UserPreference>(),
          gh<_i22.UserManager>(),
          gh<_i18.StorageService>(),
          gh<_i12.ImagePicker>(),
        ));
    gh.factory<_i53.EmployeeListBloc>(
        () => _i53.EmployeeListBloc(gh<_i28.EmployeeService>()));
    gh.factory<_i54.EmployeesCalendarLeavesBloc>(
        () => _i54.EmployeesCalendarLeavesBloc(
              gh<_i28.EmployeeService>(),
              gh<_i31.LeaveService>(),
              gh<_i22.UserManager>(),
            ));
    return this;
  }
}

class _$AppModule extends _i55.AppModule {}
