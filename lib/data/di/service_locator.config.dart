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
import 'package:http/http.dart' as _i3;
import 'package:image_picker/image_picker.dart' as _i12;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart'
    as _i15;
import 'package:projectunity/data/bloc/user_state/user_state_controller_bloc.dart'
    as _i36;
import 'package:projectunity/data/di/app_module.dart' as _i56;
import 'package:projectunity/data/pref/user_preference.dart' as _i21;
import 'package:projectunity/data/provider/device_info.dart' as _i7;
import 'package:projectunity/data/provider/user_state.dart' as _i22;
import 'package:projectunity/data/Repo/employee_repo.dart' as _i44;
import 'package:projectunity/data/Repo/leave_repo.dart' as _i46;
import 'package:projectunity/data/services/account_service.dart' as _i23;
import 'package:projectunity/data/services/auth_service.dart' as _i25;
import 'package:projectunity/data/services/employee_service.dart' as _i27;
import 'package:projectunity/data/services/invitation_services.dart' as _i13;
import 'package:projectunity/data/services/leave_service.dart' as _i30;
import 'package:projectunity/data/services/mail_notification_service.dart'
    as _i16;
import 'package:projectunity/data/services/space_service.dart' as _i19;
import 'package:projectunity/data/services/storage_service.dart' as _i20;
import 'package:projectunity/data/state_manager/auth/desktop/desktop_auth_manager.dart'
    as _i5;
import 'package:projectunity/ui/admin/drawer_options/edit_space/bloc/edit_space_bloc.dart'
    as _i26;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i53;
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_bloc.dart'
    as _i28;
import 'package:projectunity/ui/admin/leaves/details/bloc/admin_leave_details_bloc.dart'
    as _i38;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i54;
import 'package:projectunity/ui/admin/members/detail/bloc/employee_detail_bloc.dart'
    as _i42;
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i52;
import 'package:projectunity/ui/admin/members/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i37;
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart'
    as _i55;
import 'package:projectunity/ui/navigation/app_router.dart' as _i24;
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart'
    as _i41;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart'
    as _i8;
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart'
    as _i45;
import 'package:projectunity/ui/shared/profile/edit_profile/bloc/employee_edit_profile_bloc.dart'
    as _i43;
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_bloc.dart'
    as _i50;
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_bloc.dart'
    as _i51;
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart' as _i31;
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart'
    as _i40;
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart'
    as _i29;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i48;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart'
    as _i14;
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart'
    as _i33;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i39;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i35;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i34;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i49;
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_bloc.dart'
    as _i32;
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_bloc.dart'
    as _i47;
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_bloc.dart'
    as _i17;
import 'package:shared_preferences/shared_preferences.dart' as _i18;

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
    gh.factory<_i3.Client>(() => appModule.httpClient);
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
    gh.lazySingleton<_i16.NotificationService>(
      () => _i16.NotificationService(gh<_i3.Client>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i17.PickImageBloc>(
        () => _i17.PickImageBloc(gh<_i12.ImagePicker>()));
    await gh.factoryAsync<_i18.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i19.SpaceService>(
        () => _i19.SpaceService(gh<_i10.FirebaseFirestore>()));
    gh.lazySingleton<_i20.StorageService>(
        () => _i20.StorageService(gh<_i11.FirebaseStorage>()));
    gh.singleton<_i21.UserPreference>(
        _i21.UserPreference(gh<_i18.SharedPreferences>()));
    gh.singleton<_i22.UserStateNotifier>(
        _i22.UserStateNotifier(gh<_i21.UserPreference>()));
    gh.lazySingleton<_i23.AccountService>(() => _i23.AccountService(
          gh<_i10.FirebaseFirestore>(),
          gh<_i7.DeviceInfoProvider>(),
        ));
    gh.factory<_i24.AppRouter>(
        () => _i24.AppRouter(gh<_i22.UserStateNotifier>()));
    gh.singleton<_i25.AuthService>(_i25.AuthService(
      gh<_i5.DesktopAuthManager>(),
      gh<_i10.FirebaseFirestore>(),
      gh<_i9.FirebaseAuth>(),
    ));
    gh.factory<_i26.EditSpaceBloc>(() => _i26.EditSpaceBloc(
          gh<_i19.SpaceService>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i12.ImagePicker>(),
          gh<_i20.StorageService>(),
        ));
    gh.lazySingleton<_i27.EmployeeService>(() => _i27.EmployeeService(
          gh<_i22.UserStateNotifier>(),
          gh<_i10.FirebaseFirestore>(),
        ));
    gh.factory<_i28.InviteMemberBloc>(() => _i28.InviteMemberBloc(
          gh<_i13.InvitationService>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i27.EmployeeService>(),
        ));
    gh.factory<_i29.JoinSpaceBloc>(() => _i29.JoinSpaceBloc(
          gh<_i13.InvitationService>(),
          gh<_i19.SpaceService>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i23.AccountService>(),
          gh<_i27.EmployeeService>(),
          gh<_i25.AuthService>(),
        ));
    gh.lazySingleton<_i30.LeaveService>(() => _i30.LeaveService(
          gh<_i22.UserStateNotifier>(),
          gh<_i10.FirebaseFirestore>(),
        ));
    gh.factory<_i31.SignInBloc>(() => _i31.SignInBloc(
          gh<_i22.UserStateNotifier>(),
          gh<_i25.AuthService>(),
          gh<_i23.AccountService>(),
        ));
    gh.factory<_i32.UserEmployeeDetailBloc>(() => _i32.UserEmployeeDetailBloc(
          gh<_i27.EmployeeService>(),
          gh<_i30.LeaveService>(),
        ));
    gh.factory<_i33.UserLeaveCalendarBloc>(() => _i33.UserLeaveCalendarBloc(
          gh<_i30.LeaveService>(),
          gh<_i27.EmployeeService>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i19.SpaceService>(),
        ));
    gh.factory<_i34.UserLeaveCountBloc>(() => _i34.UserLeaveCountBloc(
          gh<_i30.LeaveService>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i19.SpaceService>(),
        ));
    gh.factory<_i35.UserLeaveDetailBloc>(
        () => _i35.UserLeaveDetailBloc(gh<_i30.LeaveService>()));
    gh.factory<_i36.UserStateControllerBloc>(() => _i36.UserStateControllerBloc(
          gh<_i27.EmployeeService>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i19.SpaceService>(),
        ));
    gh.factory<_i37.AdminEditEmployeeDetailsBloc>(
        () => _i37.AdminEditEmployeeDetailsBloc(
              gh<_i27.EmployeeService>(),
              gh<_i22.UserStateNotifier>(),
              gh<_i20.StorageService>(),
            ));
    gh.factory<_i38.AdminLeaveDetailsBloc>(() => _i38.AdminLeaveDetailsBloc(
          gh<_i30.LeaveService>(),
          gh<_i16.NotificationService>(),
        ));
    gh.factory<_i39.ApplyLeaveBloc>(() => _i39.ApplyLeaveBloc(
          gh<_i22.UserStateNotifier>(),
          gh<_i30.LeaveService>(),
          gh<_i16.NotificationService>(),
        ));
    gh.factory<_i40.CreateSpaceBLoc>(() => _i40.CreateSpaceBLoc(
          gh<_i19.SpaceService>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i27.EmployeeService>(),
          gh<_i12.ImagePicker>(),
          gh<_i20.StorageService>(),
        ));
    gh.factory<_i41.DrawerBloc>(() => _i41.DrawerBloc(
          gh<_i19.SpaceService>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i23.AccountService>(),
          gh<_i27.EmployeeService>(),
        ));
    gh.factory<_i42.EmployeeDetailBloc>(() => _i42.EmployeeDetailBloc(
          gh<_i23.AccountService>(),
          gh<_i19.SpaceService>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i27.EmployeeService>(),
          gh<_i30.LeaveService>(),
        ));
    gh.factory<_i43.EmployeeEditProfileBloc>(() => _i43.EmployeeEditProfileBloc(
          gh<_i27.EmployeeService>(),
          gh<_i21.UserPreference>(),
          gh<_i22.UserStateNotifier>(),
          gh<_i20.StorageService>(),
        ));
    gh.lazySingleton<_i44.EmployeeRepo>(
      () => _i44.EmployeeRepo(
        gh<_i27.EmployeeService>(),
        gh<_i22.UserStateNotifier>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i45.EmployeesCalendarLeavesBloc>(
        () => _i45.EmployeesCalendarLeavesBloc(
              gh<_i27.EmployeeService>(),
              gh<_i30.LeaveService>(),
            ));
    gh.lazySingleton<_i46.LeaveRepo>(
      () => _i46.LeaveRepo(gh<_i30.LeaveService>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i47.UserEmployeesBloc>(
        () => _i47.UserEmployeesBloc(gh<_i44.EmployeeRepo>()));
    gh.factory<_i48.UserHomeBloc>(() => _i48.UserHomeBloc(
          gh<_i22.UserStateNotifier>(),
          gh<_i46.LeaveRepo>(),
        ));
    gh.factory<_i49.UserLeaveBloc>(() => _i49.UserLeaveBloc(
          gh<_i22.UserStateNotifier>(),
          gh<_i46.LeaveRepo>(),
        ));
    gh.factory<_i50.ViewProfileBloc>(() => _i50.ViewProfileBloc(
          gh<_i22.UserStateNotifier>(),
          gh<_i44.EmployeeRepo>(),
        ));
    gh.factory<_i51.WhoIsOutCardBloc>(() => _i51.WhoIsOutCardBloc(
          gh<_i44.EmployeeRepo>(),
          gh<_i46.LeaveRepo>(),
        ));
    gh.factory<_i52.AdminEmployeeDetailsLeavesBLoc>(
        () => _i52.AdminEmployeeDetailsLeavesBLoc(gh<_i46.LeaveRepo>()));
    gh.factory<_i53.AdminHomeBloc>(() => _i53.AdminHomeBloc(
          gh<_i46.LeaveRepo>(),
          gh<_i44.EmployeeRepo>(),
        ));
    gh.factory<_i54.AdminLeavesBloc>(() => _i54.AdminLeavesBloc(
          gh<_i46.LeaveRepo>(),
          gh<_i44.EmployeeRepo>(),
        ));
    gh.factory<_i55.AdminMembersBloc>(() => _i55.AdminMembersBloc(
          gh<_i44.EmployeeRepo>(),
          gh<_i13.InvitationService>(),
          gh<_i22.UserStateNotifier>(),
        ));
    return this;
  }
}

class _$AppModule extends _i56.AppModule {}
