// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i11;
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:device_info_plus/device_info_plus.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i9;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i10;
import 'package:firebase_storage/firebase_storage.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:image_picker/image_picker.dart' as _i14;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/app_router.dart' as _i27;
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart'
    as _i17;
import 'package:projectunity/data/bloc/user_state/space_change_notifier.dart'
    as _i21;
import 'package:projectunity/data/bloc/user_state/user_state_controller_bloc.dart'
    as _i55;
import 'package:projectunity/data/core/functions/shared_function.dart' as _i3;
import 'package:projectunity/data/di/app_module.dart' as _i62;
import 'package:projectunity/data/pref/user_preference.dart' as _i24;
import 'package:projectunity/data/provider/device_info.dart' as _i8;
import 'package:projectunity/data/provider/user_state.dart' as _i25;
import 'package:projectunity/data/repo/employee_repo.dart' as _i53;
import 'package:projectunity/data/repo/form_repo.dart' as _i31;
import 'package:projectunity/data/repo/leave_repo.dart' as _i34;
import 'package:projectunity/data/services/account_service.dart' as _i26;
import 'package:projectunity/data/services/auth_service.dart' as _i28;
import 'package:projectunity/data/services/employee_service.dart' as _i30;
import 'package:projectunity/data/services/form_service.dart' as _i13;
import 'package:projectunity/data/services/invitation_services.dart' as _i15;
import 'package:projectunity/data/services/leave_service.dart' as _i16;
import 'package:projectunity/data/services/mail_notification_service.dart'
    as _i18;
import 'package:projectunity/data/services/space_service.dart' as _i22;
import 'package:projectunity/data/services/storage_service.dart' as _i23;
import 'package:projectunity/data/state_manager/auth/desktop/desktop_auth_manager.dart'
    as _i6;
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_bloc.dart'
    as _i49;
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_bloc.dart'
    as _i45;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i58;
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_bloc.dart'
    as _i32;
import 'package:projectunity/ui/admin/leaves/details/bloc/admin_leave_details_bloc.dart'
    as _i46;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i59;
import 'package:projectunity/ui/admin/members/detail/bloc/employee_detail_bloc.dart'
    as _i61;
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i44;
import 'package:projectunity/ui/admin/members/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i43;
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart'
    as _i60;
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart'
    as _i51;
import 'package:projectunity/ui/shared/events/bloc/celebrations_bloc.dart'
    as _i48;
import 'package:projectunity/ui/shared/profile/edit_profile/bloc/employee_edit_profile_bloc.dart'
    as _i52;
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_bloc.dart'
    as _i56;
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_bloc.dart'
    as _i57;
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart' as _i36;
import 'package:projectunity/ui/sign_in/setup_profile/bloc/setup_profile_bloc.dart'
    as _i35;
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart'
    as _i50;
import 'package:projectunity/ui/space/edit_space/bloc/edit_space_bloc.dart'
    as _i29;
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart'
    as _i33;
import 'package:projectunity/ui/user/forms/form_list_screen/bloc/user_forms_list_screen_bloc.dart'
    as _i38;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i39;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i47;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i42;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i41;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i40;
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_bloc.dart'
    as _i37;
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_bloc.dart'
    as _i54;
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_bloc.dart'
    as _i19;
import 'package:shared_preferences/shared_preferences.dart' as _i20;

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
    gh.factory<_i3.AppFunctions>(() => _i3.AppFunctions());
    gh.factory<_i4.Client>(() => appModule.httpClient);
    gh.factory<_i5.Connectivity>(() => appModule.connectivity);
    gh.factory<_i6.DesktopAuthManager>(() => _i6.DesktopAuthManager());
    gh.factory<_i7.DeviceInfoPlugin>(() => appModule.deviceInfoPlugin);
    gh.factory<_i8.DeviceInfoProvider>(
        () => _i8.DeviceInfoProvider(gh<_i7.DeviceInfoPlugin>()));
    gh.factory<_i9.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i10.FirebaseCrashlytics>(() => appModule.firebaseCrashlytics);
    gh.factory<_i11.FirebaseFirestore>(() => appModule.firebaseFireStore);
    gh.factory<_i12.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.factory<_i13.FormService>(
        () => _i13.FormService(gh<_i11.FirebaseFirestore>()));
    gh.factory<_i14.ImagePicker>(() => appModule.imagePicker);
    gh.lazySingleton<_i15.InvitationService>(
        () => _i15.InvitationService(gh<_i11.FirebaseFirestore>()));
    gh.lazySingleton<_i16.LeaveService>(
        () => _i16.LeaveService(gh<_i11.FirebaseFirestore>()));
    gh.factory<_i17.NetworkConnectionBloc>(
        () => _i17.NetworkConnectionBloc(gh<_i5.Connectivity>()));
    gh.lazySingleton<_i18.NotificationService>(
      () => _i18.NotificationService(
        gh<_i4.Client>(),
        gh<_i10.FirebaseCrashlytics>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i19.PickImageBloc>(
        () => _i19.PickImageBloc(gh<_i14.ImagePicker>()));
    await gh.factoryAsync<_i20.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i21.SpaceChangeNotifier>(
        () => _i21.SpaceChangeNotifier());
    gh.lazySingleton<_i22.SpaceService>(
        () => _i22.SpaceService(gh<_i11.FirebaseFirestore>()));
    gh.lazySingleton<_i23.StorageService>(
        () => _i23.StorageService(gh<_i12.FirebaseStorage>()));
    gh.lazySingleton<_i24.UserPreference>(
        () => _i24.UserPreference(gh<_i20.SharedPreferences>()));
    gh.lazySingleton<_i25.UserStateNotifier>(() => _i25.UserStateNotifier(
          gh<_i24.UserPreference>(),
          gh<_i21.SpaceChangeNotifier>(),
          gh<_i9.FirebaseAuth>(),
        ));
    gh.lazySingleton<_i26.AccountService>(() => _i26.AccountService(
          gh<_i11.FirebaseFirestore>(),
          gh<_i8.DeviceInfoProvider>(),
        ));
    gh.factory<_i27.AppRouter>(
        () => _i27.AppRouter(gh<_i25.UserStateNotifier>()));
    gh.lazySingleton<_i28.AuthService>(() => _i28.AuthService(
          gh<_i6.DesktopAuthManager>(),
          gh<_i11.FirebaseFirestore>(),
          gh<_i9.FirebaseAuth>(),
        ));
    gh.factory<_i29.EditSpaceBloc>(() => _i29.EditSpaceBloc(
          gh<_i22.SpaceService>(),
          gh<_i25.UserStateNotifier>(),
          gh<_i14.ImagePicker>(),
          gh<_i23.StorageService>(),
        ));
    gh.lazySingleton<_i30.EmployeeService>(() => _i30.EmployeeService(
          gh<_i25.UserStateNotifier>(),
          gh<_i11.FirebaseFirestore>(),
        ));
    gh.factory<_i31.FormRepo>(() => _i31.FormRepo(
          gh<_i25.UserStateNotifier>(),
          gh<_i13.FormService>(),
        ));
    gh.factory<_i32.InviteMemberBloc>(() => _i32.InviteMemberBloc(
          gh<_i15.InvitationService>(),
          gh<_i25.UserStateNotifier>(),
          gh<_i30.EmployeeService>(),
          gh<_i18.NotificationService>(),
        ));
    gh.factory<_i33.JoinSpaceBloc>(() => _i33.JoinSpaceBloc(
          gh<_i15.InvitationService>(),
          gh<_i22.SpaceService>(),
          gh<_i25.UserStateNotifier>(),
          gh<_i26.AccountService>(),
          gh<_i30.EmployeeService>(),
          gh<_i28.AuthService>(),
          gh<_i18.NotificationService>(),
        ));
    gh.lazySingleton<_i34.LeaveRepo>(() => _i34.LeaveRepo(
          gh<_i16.LeaveService>(),
          gh<_i25.UserStateNotifier>(),
        ));
    gh.factory<_i35.SetupProfileBloc>(() => _i35.SetupProfileBloc(
          gh<_i26.AccountService>(),
          gh<_i25.UserStateNotifier>(),
        ));
    gh.factory<_i36.SignInBloc>(() => _i36.SignInBloc(
          gh<_i25.UserStateNotifier>(),
          gh<_i28.AuthService>(),
          gh<_i26.AccountService>(),
        ));
    gh.factory<_i37.UserEmployeeDetailBloc>(
        () => _i37.UserEmployeeDetailBloc(gh<_i34.LeaveRepo>()));
    gh.factory<_i38.UserFormListBloc>(
        () => _i38.UserFormListBloc(gh<_i31.FormRepo>()));
    gh.factory<_i39.UserHomeBloc>(() => _i39.UserHomeBloc(
          gh<_i25.UserStateNotifier>(),
          gh<_i34.LeaveRepo>(),
        ));
    gh.factory<_i40.UserLeaveBloc>(() => _i40.UserLeaveBloc(
          gh<_i25.UserStateNotifier>(),
          gh<_i34.LeaveRepo>(),
        ));
    gh.factory<_i41.UserLeaveCountBloc>(() => _i41.UserLeaveCountBloc(
          gh<_i34.LeaveRepo>(),
          gh<_i25.UserStateNotifier>(),
        ));
    gh.factory<_i42.UserLeaveDetailBloc>(
        () => _i42.UserLeaveDetailBloc(gh<_i34.LeaveRepo>()));
    gh.factory<_i43.AdminEditEmployeeDetailsBloc>(
        () => _i43.AdminEditEmployeeDetailsBloc(
              gh<_i30.EmployeeService>(),
              gh<_i25.UserStateNotifier>(),
              gh<_i23.StorageService>(),
            ));
    gh.factory<_i44.AdminEmployeeDetailsLeavesBLoc>(
        () => _i44.AdminEmployeeDetailsLeavesBLoc(gh<_i34.LeaveRepo>()));
    gh.factory<_i45.AdminFormListBloc>(
        () => _i45.AdminFormListBloc(gh<_i31.FormRepo>()));
    gh.factory<_i46.AdminLeaveDetailsBloc>(() => _i46.AdminLeaveDetailsBloc(
          gh<_i34.LeaveRepo>(),
          gh<_i18.NotificationService>(),
        ));
    gh.factory<_i47.ApplyLeaveBloc>(() => _i47.ApplyLeaveBloc(
          gh<_i25.UserStateNotifier>(),
          gh<_i34.LeaveRepo>(),
          gh<_i18.NotificationService>(),
          gh<_i3.AppFunctions>(),
        ));
    gh.factory<_i48.CelebrationsBloc>(
        () => _i48.CelebrationsBloc(gh<_i30.EmployeeService>()));
    gh.factory<_i49.CreateFormBloc>(() => _i49.CreateFormBloc(
          gh<_i31.FormRepo>(),
          gh<_i14.ImagePicker>(),
          gh<_i23.StorageService>(),
          gh<_i25.UserStateNotifier>(),
        ));
    gh.factory<_i50.CreateSpaceBLoc>(() => _i50.CreateSpaceBLoc(
          gh<_i22.SpaceService>(),
          gh<_i25.UserStateNotifier>(),
          gh<_i30.EmployeeService>(),
          gh<_i14.ImagePicker>(),
          gh<_i23.StorageService>(),
        ));
    gh.factory<_i51.DrawerBloc>(() => _i51.DrawerBloc(
          gh<_i22.SpaceService>(),
          gh<_i25.UserStateNotifier>(),
          gh<_i26.AccountService>(),
          gh<_i30.EmployeeService>(),
        ));
    gh.factory<_i52.EmployeeEditProfileBloc>(() => _i52.EmployeeEditProfileBloc(
          gh<_i30.EmployeeService>(),
          gh<_i24.UserPreference>(),
          gh<_i25.UserStateNotifier>(),
          gh<_i23.StorageService>(),
        ));
    gh.lazySingleton<_i53.EmployeeRepo>(
      () => _i53.EmployeeRepo(
        gh<_i30.EmployeeService>(),
        gh<_i25.UserStateNotifier>(),
        gh<_i10.FirebaseCrashlytics>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i54.UserEmployeesBloc>(
        () => _i54.UserEmployeesBloc(gh<_i53.EmployeeRepo>()));
    gh.factory<_i55.UserStateControllerBloc>(() => _i55.UserStateControllerBloc(
          gh<_i53.EmployeeRepo>(),
          gh<_i25.UserStateNotifier>(),
          gh<_i22.SpaceService>(),
          gh<_i21.SpaceChangeNotifier>(),
        ));
    gh.factory<_i56.ViewProfileBloc>(() => _i56.ViewProfileBloc(
          gh<_i25.UserStateNotifier>(),
          gh<_i53.EmployeeRepo>(),
        ));
    gh.factory<_i57.WhoIsOutCardBloc>(() => _i57.WhoIsOutCardBloc(
          gh<_i53.EmployeeRepo>(),
          gh<_i34.LeaveRepo>(),
        ));
    gh.factory<_i58.AdminHomeBloc>(() => _i58.AdminHomeBloc(
          gh<_i34.LeaveRepo>(),
          gh<_i53.EmployeeRepo>(),
        ));
    gh.factory<_i59.AdminLeavesBloc>(() => _i59.AdminLeavesBloc(
          gh<_i34.LeaveRepo>(),
          gh<_i53.EmployeeRepo>(),
        ));
    gh.factory<_i60.AdminMembersBloc>(() => _i60.AdminMembersBloc(
          gh<_i53.EmployeeRepo>(),
          gh<_i15.InvitationService>(),
          gh<_i25.UserStateNotifier>(),
        ));
    gh.factory<_i61.EmployeeDetailBloc>(() => _i61.EmployeeDetailBloc(
          gh<_i26.AccountService>(),
          gh<_i22.SpaceService>(),
          gh<_i25.UserStateNotifier>(),
          gh<_i30.EmployeeService>(),
          gh<_i34.LeaveRepo>(),
          gh<_i53.EmployeeRepo>(),
        ));
    return this;
  }
}

class _$AppModule extends _i62.AppModule {}
