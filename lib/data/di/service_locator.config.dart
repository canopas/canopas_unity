// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i9;
import 'package:connectivity_plus/connectivity_plus.dart' as _i3;
import 'package:device_info_plus/device_info_plus.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i8;
import 'package:firebase_storage/firebase_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart'
    as _i14;
import 'package:projectunity/data/bloc/user_state/user_state_controller_bloc.dart'
    as _i36;
import 'package:projectunity/data/di/app_module.dart' as _i51;
import 'package:projectunity/data/pref/user_preference.dart' as _i18;
import 'package:projectunity/data/provider/device_info.dart' as _i6;
import 'package:projectunity/data/provider/user_state.dart' as _i19;
import 'package:projectunity/data/services/account_service.dart' as _i20;
import 'package:projectunity/data/services/auth_service.dart' as _i22;
import 'package:projectunity/data/services/employee_service.dart' as _i24;
import 'package:projectunity/data/services/invitation_services.dart' as _i12;
import 'package:projectunity/data/services/leave_service.dart' as _i27;
import 'package:projectunity/data/services/space_service.dart' as _i16;
import 'package:projectunity/data/services/storage_service.dart' as _i17;
import 'package:projectunity/data/state_manager/auth/desktop/desktop_auth_manager.dart'
    as _i4;
import 'package:projectunity/ui/admin/drawer_options/edit_space/bloc/edit_space_bloc.dart'
    as _i23;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i41;
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_bloc.dart'
    as _i25;
import 'package:projectunity/ui/admin/leaves/details/bloc/admin_leave_details_bloc.dart'
    as _i42;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i43;
import 'package:projectunity/ui/admin/members/detail/bloc/employee_detail_bloc.dart'
    as _i48;
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i40;
import 'package:projectunity/ui/admin/members/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i39;
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart'
    as _i44;
import 'package:projectunity/ui/navigation/app_router.dart' as _i21;
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart'
    as _i47;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i7;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i50;
import 'package:projectunity/ui/shared/profile/edit_profile/bloc/employee_edit_profile_bloc.dart'
    as _i49;
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_bloc.dart'
    as _i37;
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_bloc.dart'
    as _i38;
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart' as _i28;
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart'
    as _i46;
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart'
    as _i26;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i30;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i13;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i32;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i45;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i34;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i33;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i31;
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_bloc.dart'
    as _i29;
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_bloc.dart'
    as _i35;
import 'package:shared_preferences/shared_preferences.dart' as _i15;

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
    gh.factory<_i3.Connectivity>(() => appModule.connectivity);
    gh.factory<_i4.DesktopAuthManager>(() => _i4.DesktopAuthManager());
    gh.factory<_i5.DeviceInfoPlugin>(() => appModule.deviceInfoPlugin);
    gh.factory<_i6.DeviceInfoProvider>(
        () => _i6.DeviceInfoProvider(gh<_i5.DeviceInfoPlugin>()));
    gh.factory<_i7.EmployeesCalenderBloc>(() => _i7.EmployeesCalenderBloc());
    gh.factory<_i8.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i9.FirebaseFirestore>(() => appModule.firebaseFireStore);
    gh.factory<_i10.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.factory<_i11.ImagePicker>(() => appModule.imagePicker);
    gh.lazySingleton<_i12.InvitationService>(
        () => _i12.InvitationService(gh<_i9.FirebaseFirestore>()));
    gh.factory<_i13.LeaveCalendarBloc>(() => _i13.LeaveCalendarBloc());
    gh.factory<_i14.NetworkConnectionBloc>(
        () => _i14.NetworkConnectionBloc(gh<_i3.Connectivity>()));
    await gh.factoryAsync<_i15.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i16.SpaceService>(
        () => _i16.SpaceService(gh<_i9.FirebaseFirestore>()));
    gh.lazySingleton<_i17.StorageService>(
        () => _i17.StorageService(gh<_i10.FirebaseStorage>()));
    gh.singleton<_i18.UserPreference>(
        _i18.UserPreference(gh<_i15.SharedPreferences>()));
    gh.singleton<_i19.UserStateNotifier>(
        _i19.UserStateNotifier(gh<_i18.UserPreference>()));
    gh.lazySingleton<_i20.AccountService>(() => _i20.AccountService(
          gh<_i9.FirebaseFirestore>(),
          gh<_i6.DeviceInfoProvider>(),
        ));
    gh.factory<_i21.AppRouter>(
        () => _i21.AppRouter(gh<_i19.UserStateNotifier>()));
    gh.singleton<_i22.AuthService>(_i22.AuthService(
      gh<_i4.DesktopAuthManager>(),
      gh<_i9.FirebaseFirestore>(),
      gh<_i8.FirebaseAuth>(),
    ));
    gh.factory<_i23.EditSpaceBloc>(() => _i23.EditSpaceBloc(
          gh<_i16.SpaceService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i11.ImagePicker>(),
          gh<_i17.StorageService>(),
        ));
    gh.lazySingleton<_i24.EmployeeService>(() => _i24.EmployeeService(
          gh<_i19.UserStateNotifier>(),
          gh<_i9.FirebaseFirestore>(),
        ));
    gh.factory<_i25.InviteMemberBloc>(() => _i25.InviteMemberBloc(
          gh<_i12.InvitationService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i24.EmployeeService>(),
        ));
    gh.factory<_i26.JoinSpaceBloc>(() => _i26.JoinSpaceBloc(
          gh<_i12.InvitationService>(),
          gh<_i16.SpaceService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i20.AccountService>(),
          gh<_i24.EmployeeService>(),
        ));
    gh.lazySingleton<_i27.LeaveService>(() => _i27.LeaveService(
          gh<_i19.UserStateNotifier>(),
          gh<_i9.FirebaseFirestore>(),
        ));
    gh.factory<_i28.SignInBloc>(() => _i28.SignInBloc(
          gh<_i19.UserStateNotifier>(),
          gh<_i22.AuthService>(),
          gh<_i20.AccountService>(),
        ));
    gh.factory<_i29.UserEmployeeDetailBloc>(() => _i29.UserEmployeeDetailBloc(
          gh<_i24.EmployeeService>(),
          gh<_i27.LeaveService>(),
        ));
    gh.factory<_i30.UserHomeBloc>(() => _i30.UserHomeBloc(
          gh<_i19.UserStateNotifier>(),
          gh<_i27.LeaveService>(),
        ));
    gh.factory<_i31.UserLeaveBloc>(() => _i31.UserLeaveBloc(
          gh<_i19.UserStateNotifier>(),
          gh<_i27.LeaveService>(),
        ));
    gh.factory<_i32.UserLeaveCalendarBloc>(() => _i32.UserLeaveCalendarBloc(
          gh<_i27.LeaveService>(),
          gh<_i24.EmployeeService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i16.SpaceService>(),
        ));
    gh.factory<_i33.UserLeaveCountBloc>(() => _i33.UserLeaveCountBloc(
          gh<_i27.LeaveService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i16.SpaceService>(),
        ));
    gh.factory<_i34.UserLeaveDetailBloc>(
        () => _i34.UserLeaveDetailBloc(gh<_i27.LeaveService>()));
    gh.factory<_i35.UserMembersBloc>(
        () => _i35.UserMembersBloc(gh<_i24.EmployeeService>()));
    gh.factory<_i36.UserStateControllerBloc>(() => _i36.UserStateControllerBloc(
          gh<_i24.EmployeeService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i16.SpaceService>(),
        ));
    gh.factory<_i37.ViewProfileBloc>(() => _i37.ViewProfileBloc(
          gh<_i19.UserStateNotifier>(),
          gh<_i24.EmployeeService>(),
        ));
    gh.factory<_i38.WhoIsOutCardBloc>(() => _i38.WhoIsOutCardBloc(
          gh<_i24.EmployeeService>(),
          gh<_i27.LeaveService>(),
        ));
    gh.factory<_i39.AdminEditEmployeeDetailsBloc>(
        () => _i39.AdminEditEmployeeDetailsBloc(gh<_i24.EmployeeService>()));
    gh.factory<_i40.AdminEmployeeDetailsLeavesBLoc>(
        () => _i40.AdminEmployeeDetailsLeavesBLoc(gh<_i27.LeaveService>()));
    gh.factory<_i41.AdminHomeBloc>(() => _i41.AdminHomeBloc(
          gh<_i27.LeaveService>(),
          gh<_i24.EmployeeService>(),
        ));
    gh.factory<_i42.AdminLeaveDetailsBloc>(() => _i42.AdminLeaveDetailsBloc(
          gh<_i27.LeaveService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i16.SpaceService>(),
        ));
    gh.factory<_i43.AdminLeavesBloc>(() => _i43.AdminLeavesBloc(
          gh<_i27.LeaveService>(),
          gh<_i24.EmployeeService>(),
        ));
    gh.factory<_i44.AdminMembersBloc>(() => _i44.AdminMembersBloc(
          gh<_i24.EmployeeService>(),
          gh<_i12.InvitationService>(),
          gh<_i19.UserStateNotifier>(),
        ));
    gh.factory<_i45.ApplyLeaveBloc>(() => _i45.ApplyLeaveBloc(
          gh<_i19.UserStateNotifier>(),
          gh<_i27.LeaveService>(),
        ));
    gh.factory<_i46.CreateSpaceBLoc>(() => _i46.CreateSpaceBLoc(
          gh<_i16.SpaceService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i24.EmployeeService>(),
          gh<_i11.ImagePicker>(),
          gh<_i17.StorageService>(),
        ));
    gh.factory<_i47.DrawerBloc>(() => _i47.DrawerBloc(
          gh<_i16.SpaceService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i20.AccountService>(),
          gh<_i24.EmployeeService>(),
          gh<_i22.AuthService>(),
        ));
    gh.factory<_i48.EmployeeDetailBloc>(() => _i48.EmployeeDetailBloc(
          gh<_i20.AccountService>(),
          gh<_i16.SpaceService>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i24.EmployeeService>(),
          gh<_i27.LeaveService>(),
        ));
    gh.factory<_i49.EmployeeEditProfileBloc>(() => _i49.EmployeeEditProfileBloc(
          gh<_i24.EmployeeService>(),
          gh<_i18.UserPreference>(),
          gh<_i19.UserStateNotifier>(),
          gh<_i17.StorageService>(),
          gh<_i11.ImagePicker>(),
        ));
    gh.factory<_i50.EmployeesCalendarLeavesBloc>(
        () => _i50.EmployeesCalendarLeavesBloc(
              gh<_i24.EmployeeService>(),
              gh<_i27.LeaveService>(),
            ));
    return this;
  }
}

class _$AppModule extends _i51.AppModule {}
