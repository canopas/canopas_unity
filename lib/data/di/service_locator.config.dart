// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i8;
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:firebase_storage/firebase_storage.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart'
    as _i13;
import 'package:projectunity/data/di/app_module.dart' as _i53;
import 'package:projectunity/data/pref/user_preference.dart' as _i17;
import 'package:projectunity/data/provider/user_data.dart' as _i20;
import 'package:projectunity/data/services/account_service.dart' as _i18;
import 'package:projectunity/data/services/auth_service.dart' as _i19;
import 'package:projectunity/data/services/employee_service.dart' as _i26;
import 'package:projectunity/data/services/invitation_services.dart' as _i11;
import 'package:projectunity/data/services/leave_service.dart' as _i29;
import 'package:projectunity/data/services/space_service.dart' as _i15;
import 'package:projectunity/data/services/storage_service.dart' as _i16;
import 'package:projectunity/data/state_manager/auth/desktop/desktop_auth_manager.dart'
    as _i5;
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_bloc.dart'
    as _i49;
import 'package:projectunity/ui/admin/employee/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i41;
import 'package:projectunity/ui/admin/employee/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i40;
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_bloc.dart'
    as _i51;
import 'package:projectunity/ui/admin/home/addmember/bloc/add_member_bloc.dart'
    as _i39;
import 'package:projectunity/ui/admin/home/application_detail/bloc/admin_leave_application_detail_bloc.dart'
    as _i43;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i42;
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_bloc.dart'
    as _i27;
import 'package:projectunity/ui/admin/leaves/detail/bloc/admin_leave_detail_bloc.dart'
    as _i44;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i45;
import 'package:projectunity/ui/admin/setting/edit_space/bloc/edit_space_bloc.dart'
    as _i25;
import 'package:projectunity/ui/admin/setting/settings_screen/bloc/admin_settings_bloc.dart'
    as _i23;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart'
    as _i22;
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart'
    as _i3;
import 'package:projectunity/ui/navigation/app_router.dart' as _i24;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i6;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i52;
import 'package:projectunity/ui/shared/WhoIsOutCard/bloc/who_is_out_card_bloc.dart'
    as _i38;
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart' as _i30;
import 'package:projectunity/ui/space/change_space_sheet/bloc/change_space_bloc.dart'
    as _i47;
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart'
    as _i48;
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart'
    as _i28;
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart'
    as _i31;
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_bloc.dart'
    as _i32;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i33;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i12;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i35;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i46;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i37;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i36;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i34;
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_bloc.dart'
    as _i50;
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_bloc.dart'
    as _i21;
import 'package:shared_preferences/shared_preferences.dart' as _i14;

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
    gh.factory<_i6.EmployeesCalenderBloc>(() => _i6.EmployeesCalenderBloc());
    gh.factory<_i7.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i8.FirebaseFirestore>(() => appModule.firebaseFireStore);
    gh.factory<_i9.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.factory<_i10.ImagePicker>(() => appModule.imagePicker);
    gh.lazySingleton<_i11.InvitationService>(
        () => _i11.InvitationService(gh<_i8.FirebaseFirestore>()));
    gh.factory<_i12.LeaveCalendarBloc>(() => _i12.LeaveCalendarBloc());
    gh.factory<_i13.NetworkConnectionBloc>(
        () => _i13.NetworkConnectionBloc(gh<_i4.Connectivity>()));
    await gh.factoryAsync<_i14.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i15.SpaceService>(
        () => _i15.SpaceService(gh<_i8.FirebaseFirestore>()));
    gh.lazySingleton<_i16.StorageService>(
        () => _i16.StorageService(gh<_i9.FirebaseStorage>()));
    gh.singleton<_i17.UserPreference>(
        _i17.UserPreference(gh<_i14.SharedPreferences>()));
    gh.lazySingleton<_i18.AccountService>(
        () => _i18.AccountService(gh<_i8.FirebaseFirestore>()));
    gh.singleton<_i19.AuthService>(_i19.AuthService(
      gh<_i5.DesktopAuthManager>(),
      gh<_i8.FirebaseFirestore>(),
      gh<_i7.FirebaseAuth>(),
    ));
    gh.singleton<_i20.UserManager>(_i20.UserManager(gh<_i17.UserPreference>()));
    gh.factory<_i21.UserSettingsBloc>(() => _i21.UserSettingsBloc(
          gh<_i20.UserManager>(),
          gh<_i19.AuthService>(),
        ));
    gh.factory<_i22.AdminSettingUpdatePaidLeaveCountBloc>(
        () => _i22.AdminSettingUpdatePaidLeaveCountBloc(
              gh<_i15.SpaceService>(),
              gh<_i20.UserManager>(),
            ));
    gh.factory<_i23.AdminSettingsBloc>(() => _i23.AdminSettingsBloc(
          gh<_i20.UserManager>(),
          gh<_i19.AuthService>(),
        ));
    gh.factory<_i24.AppRouter>(() => _i24.AppRouter(gh<_i20.UserManager>()));
    gh.factory<_i25.EditSpaceBloc>(() => _i25.EditSpaceBloc(
          gh<_i15.SpaceService>(),
          gh<_i20.UserManager>(),
        ));
    gh.lazySingleton<_i26.EmployeeService>(() => _i26.EmployeeService(
          gh<_i20.UserManager>(),
          gh<_i8.FirebaseFirestore>(),
        ));
    gh.factory<_i27.InviteMemberBloc>(() => _i27.InviteMemberBloc(
          gh<_i11.InvitationService>(),
          gh<_i20.UserManager>(),
        ));
    gh.factory<_i28.JoinSpaceBloc>(() => _i28.JoinSpaceBloc(
          gh<_i11.InvitationService>(),
          gh<_i15.SpaceService>(),
          gh<_i20.UserManager>(),
          gh<_i26.EmployeeService>(),
        ));
    gh.lazySingleton<_i29.LeaveService>(() => _i29.LeaveService(
          gh<_i20.UserManager>(),
          gh<_i8.FirebaseFirestore>(),
        ));
    gh.factory<_i30.SignInBloc>(() => _i30.SignInBloc(
          gh<_i20.UserManager>(),
          gh<_i19.AuthService>(),
        ));
    gh.factory<_i31.UserEmployeeDetailBloc>(() => _i31.UserEmployeeDetailBloc(
          gh<_i26.EmployeeService>(),
          gh<_i29.LeaveService>(),
        ));
    gh.factory<_i32.UserEmployeesBloc>(() => _i32.UserEmployeesBloc(
          gh<_i26.EmployeeService>(),
          gh<_i20.UserManager>(),
        ));
    gh.factory<_i33.UserHomeBloc>(() => _i33.UserHomeBloc(
          gh<_i19.AuthService>(),
          gh<_i20.UserManager>(),
          gh<_i29.LeaveService>(),
        ));
    gh.factory<_i34.UserLeaveBloc>(() => _i34.UserLeaveBloc(
          gh<_i20.UserManager>(),
          gh<_i29.LeaveService>(),
        ));
    gh.factory<_i35.UserLeaveCalendarBloc>(() => _i35.UserLeaveCalendarBloc(
          gh<_i29.LeaveService>(),
          gh<_i26.EmployeeService>(),
          gh<_i20.UserManager>(),
          gh<_i15.SpaceService>(),
        ));
    gh.factory<_i36.UserLeaveCountBloc>(() => _i36.UserLeaveCountBloc(
          gh<_i29.LeaveService>(),
          gh<_i20.UserManager>(),
          gh<_i15.SpaceService>(),
        ));
    gh.factory<_i37.UserLeaveDetailBloc>(
        () => _i37.UserLeaveDetailBloc(gh<_i29.LeaveService>()));
    gh.factory<_i38.WhoIsOutCardBloc>(() => _i38.WhoIsOutCardBloc(
          gh<_i26.EmployeeService>(),
          gh<_i29.LeaveService>(),
        ));
    gh.factory<_i39.AddMemberBloc>(
        () => _i39.AddMemberBloc(gh<_i26.EmployeeService>()));
    gh.factory<_i40.AdminEditEmployeeDetailsBloc>(
        () => _i40.AdminEditEmployeeDetailsBloc(gh<_i26.EmployeeService>()));
    gh.factory<_i41.AdminEmployeeDetailsLeavesBLoc>(
        () => _i41.AdminEmployeeDetailsLeavesBLoc(gh<_i29.LeaveService>()));
    gh.factory<_i42.AdminHomeBloc>(() => _i42.AdminHomeBloc(
          gh<_i29.LeaveService>(),
          gh<_i26.EmployeeService>(),
          gh<_i20.UserManager>(),
        ));
    gh.factory<_i43.AdminLeaveApplicationDetailsBloc>(
        () => _i43.AdminLeaveApplicationDetailsBloc(
              gh<_i29.LeaveService>(),
              gh<_i20.UserManager>(),
              gh<_i15.SpaceService>(),
            ));
    gh.factory<_i44.AdminLeaveDetailBloc>(() => _i44.AdminLeaveDetailBloc(
          gh<_i29.LeaveService>(),
          gh<_i20.UserManager>(),
          gh<_i15.SpaceService>(),
        ));
    gh.factory<_i45.AdminLeavesBloc>(() => _i45.AdminLeavesBloc(
          gh<_i29.LeaveService>(),
          gh<_i26.EmployeeService>(),
        ));
    gh.factory<_i46.ApplyLeaveBloc>(() => _i46.ApplyLeaveBloc(
          gh<_i20.UserManager>(),
          gh<_i29.LeaveService>(),
        ));
    gh.factory<_i47.ChangeSpaceBloc>(() => _i47.ChangeSpaceBloc(
          gh<_i20.UserManager>(),
          gh<_i15.SpaceService>(),
          gh<_i26.EmployeeService>(),
        ));
    gh.factory<_i48.CreateSpaceBLoc>(() => _i48.CreateSpaceBLoc(
          gh<_i15.SpaceService>(),
          gh<_i20.UserManager>(),
          gh<_i26.EmployeeService>(),
        ));
    gh.factory<_i49.EmployeeDetailBloc>(() => _i49.EmployeeDetailBloc(
          gh<_i15.SpaceService>(),
          gh<_i20.UserManager>(),
          gh<_i26.EmployeeService>(),
          gh<_i29.LeaveService>(),
        ));
    gh.factory<_i50.EmployeeEditProfileBloc>(() => _i50.EmployeeEditProfileBloc(
          gh<_i26.EmployeeService>(),
          gh<_i17.UserPreference>(),
          gh<_i20.UserManager>(),
          gh<_i16.StorageService>(),
          gh<_i10.ImagePicker>(),
        ));
    gh.factory<_i51.EmployeeListBloc>(
        () => _i51.EmployeeListBloc(gh<_i26.EmployeeService>()));
    gh.factory<_i52.EmployeesCalendarLeavesBloc>(
        () => _i52.EmployeesCalendarLeavesBloc(
              gh<_i26.EmployeeService>(),
              gh<_i29.LeaveService>(),
              gh<_i20.UserManager>(),
            ));
    return this;
  }
}

class _$AppModule extends _i53.AppModule {}
