// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i12;
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:device_info_plus/device_info_plus.dart' as _i8;
import 'package:firebase_auth/firebase_auth.dart' as _i10;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i11;
import 'package:firebase_storage/firebase_storage.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:image_picker/image_picker.dart' as _i15;
import 'package:injectable/injectable.dart' as _i2;
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart'
    as _i18;
import 'package:projectunity/data/bloc/user_state/space_change_notifier.dart'
    as _i22;
import 'package:projectunity/data/bloc/user_state/user_state_controller_bloc.dart'
    as _i50;
import 'package:projectunity/data/core/functions/shared_function.dart' as _i3;
import 'package:projectunity/data/di/app_module.dart' as _i57;
import 'package:projectunity/data/pref/user_preference.dart' as _i25;
import 'package:projectunity/data/provider/device_info.dart' as _i9;
import 'package:projectunity/data/provider/user_state.dart' as _i26;
import 'package:projectunity/data/repo/employee_repo.dart' as _i48;
import 'package:projectunity/data/repo/leave_repo.dart' as _i34;
import 'package:projectunity/data/services/account_service.dart' as _i27;
import 'package:projectunity/data/services/auth_service.dart' as _i29;
import 'package:projectunity/data/services/employee_service.dart' as _i31;
import 'package:projectunity/data/services/form_service.dart' as _i14;
import 'package:projectunity/data/services/invitation_services.dart' as _i16;
import 'package:projectunity/data/services/leave_service.dart' as _i17;
import 'package:projectunity/data/services/mail_notification_service.dart'
    as _i19;
import 'package:projectunity/data/services/space_service.dart' as _i23;
import 'package:projectunity/data/services/storage_service.dart' as _i24;
import 'package:projectunity/data/state_manager/auth/desktop/desktop_auth_manager.dart'
    as _i7;
import 'package:projectunity/ui/admin/drawer_options/edit_space/bloc/edit_space_bloc.dart'
    as _i30;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i53;
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_bloc.dart'
    as _i32;
import 'package:projectunity/ui/admin/leaves/details/bloc/admin_leave_details_bloc.dart'
    as _i43;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i54;
import 'package:projectunity/ui/admin/members/detail/bloc/employee_detail_bloc.dart'
    as _i56;
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i42;
import 'package:projectunity/ui/admin/members/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i41;
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart'
    as _i55;
import 'package:projectunity/ui/forms/create_form/bloc/create_form_bloc.dart'
    as _i6;
import 'package:projectunity/ui/navigation/app_router.dart' as _i28;
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart'
    as _i46;
import 'package:projectunity/ui/shared/profile/edit_profile/bloc/employee_edit_profile_bloc.dart'
    as _i47;
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_bloc.dart'
    as _i51;
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_bloc.dart'
    as _i52;
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart' as _i35;
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart'
    as _i45;
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart'
    as _i33;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i37;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i44;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i40;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i39;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i38;
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_bloc.dart'
    as _i36;
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_bloc.dart'
    as _i49;
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_bloc.dart'
    as _i20;
import 'package:shared_preferences/shared_preferences.dart' as _i21;

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
    gh.factory<_i6.CreateFormBloc>(() => _i6.CreateFormBloc());
    gh.factory<_i7.DesktopAuthManager>(() => _i7.DesktopAuthManager());
    gh.factory<_i8.DeviceInfoPlugin>(() => appModule.deviceInfoPlugin);
    gh.factory<_i9.DeviceInfoProvider>(
        () => _i9.DeviceInfoProvider(gh<_i8.DeviceInfoPlugin>()));
    gh.factory<_i10.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i11.FirebaseCrashlytics>(() => appModule.firebaseCrashlytics);
    gh.factory<_i12.FirebaseFirestore>(() => appModule.firebaseFireStore);
    gh.factory<_i13.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.factory<_i14.FormService>(
        () => _i14.FormService(gh<_i12.FirebaseFirestore>()));
    gh.factory<_i15.ImagePicker>(() => appModule.imagePicker);
    gh.lazySingleton<_i16.InvitationService>(
        () => _i16.InvitationService(gh<_i12.FirebaseFirestore>()));
    gh.lazySingleton<_i17.LeaveService>(
        () => _i17.LeaveService(gh<_i12.FirebaseFirestore>()));
    gh.factory<_i18.NetworkConnectionBloc>(
        () => _i18.NetworkConnectionBloc(gh<_i5.Connectivity>()));
    gh.lazySingleton<_i19.NotificationService>(
      () => _i19.NotificationService(
        gh<_i4.Client>(),
        gh<_i11.FirebaseCrashlytics>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i20.PickImageBloc>(
        () => _i20.PickImageBloc(gh<_i15.ImagePicker>()));
    await gh.factoryAsync<_i21.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i22.SpaceChangeNotifier>(
        () => _i22.SpaceChangeNotifier());
    gh.lazySingleton<_i23.SpaceService>(
        () => _i23.SpaceService(gh<_i12.FirebaseFirestore>()));
    gh.lazySingleton<_i24.StorageService>(
        () => _i24.StorageService(gh<_i13.FirebaseStorage>()));
    gh.singleton<_i25.UserPreference>(
        _i25.UserPreference(gh<_i21.SharedPreferences>()));
    gh.lazySingleton<_i26.UserStateNotifier>(() => _i26.UserStateNotifier(
          gh<_i25.UserPreference>(),
          gh<_i22.SpaceChangeNotifier>(),
        ));
    gh.lazySingleton<_i27.AccountService>(() => _i27.AccountService(
          gh<_i12.FirebaseFirestore>(),
          gh<_i9.DeviceInfoProvider>(),
        ));
    gh.factory<_i28.AppRouter>(
        () => _i28.AppRouter(gh<_i26.UserStateNotifier>()));
    gh.singleton<_i29.AuthService>(_i29.AuthService(
      gh<_i7.DesktopAuthManager>(),
      gh<_i12.FirebaseFirestore>(),
      gh<_i10.FirebaseAuth>(),
    ));
    gh.factory<_i30.EditSpaceBloc>(() => _i30.EditSpaceBloc(
          gh<_i23.SpaceService>(),
          gh<_i26.UserStateNotifier>(),
          gh<_i15.ImagePicker>(),
          gh<_i24.StorageService>(),
        ));
    gh.lazySingleton<_i31.EmployeeService>(() => _i31.EmployeeService(
          gh<_i26.UserStateNotifier>(),
          gh<_i12.FirebaseFirestore>(),
        ));
    gh.factory<_i32.InviteMemberBloc>(() => _i32.InviteMemberBloc(
          gh<_i16.InvitationService>(),
          gh<_i26.UserStateNotifier>(),
          gh<_i31.EmployeeService>(),
          gh<_i19.NotificationService>(),
        ));
    gh.factory<_i33.JoinSpaceBloc>(() => _i33.JoinSpaceBloc(
          gh<_i16.InvitationService>(),
          gh<_i23.SpaceService>(),
          gh<_i26.UserStateNotifier>(),
          gh<_i27.AccountService>(),
          gh<_i31.EmployeeService>(),
          gh<_i29.AuthService>(),
          gh<_i19.NotificationService>(),
        ));
    gh.lazySingleton<_i34.LeaveRepo>(() => _i34.LeaveRepo(
          gh<_i17.LeaveService>(),
          gh<_i26.UserStateNotifier>(),
        ));
    gh.factory<_i35.SignInBloc>(() => _i35.SignInBloc(
          gh<_i26.UserStateNotifier>(),
          gh<_i29.AuthService>(),
          gh<_i27.AccountService>(),
        ));
    gh.factory<_i36.UserEmployeeDetailBloc>(
        () => _i36.UserEmployeeDetailBloc(gh<_i34.LeaveRepo>()));
    gh.factory<_i37.UserHomeBloc>(() => _i37.UserHomeBloc(
          gh<_i26.UserStateNotifier>(),
          gh<_i34.LeaveRepo>(),
        ));
    gh.factory<_i38.UserLeaveBloc>(() => _i38.UserLeaveBloc(
          gh<_i26.UserStateNotifier>(),
          gh<_i34.LeaveRepo>(),
        ));
    gh.factory<_i39.UserLeaveCountBloc>(() => _i39.UserLeaveCountBloc(
          gh<_i34.LeaveRepo>(),
          gh<_i26.UserStateNotifier>(),
          gh<_i23.SpaceService>(),
        ));
    gh.factory<_i40.UserLeaveDetailBloc>(
        () => _i40.UserLeaveDetailBloc(gh<_i34.LeaveRepo>()));
    gh.factory<_i41.AdminEditEmployeeDetailsBloc>(
        () => _i41.AdminEditEmployeeDetailsBloc(
              gh<_i31.EmployeeService>(),
              gh<_i26.UserStateNotifier>(),
              gh<_i24.StorageService>(),
            ));
    gh.factory<_i42.AdminEmployeeDetailsLeavesBLoc>(
        () => _i42.AdminEmployeeDetailsLeavesBLoc(gh<_i34.LeaveRepo>()));
    gh.factory<_i43.AdminLeaveDetailsBloc>(() => _i43.AdminLeaveDetailsBloc(
          gh<_i34.LeaveRepo>(),
          gh<_i19.NotificationService>(),
        ));
    gh.factory<_i44.ApplyLeaveBloc>(() => _i44.ApplyLeaveBloc(
          gh<_i26.UserStateNotifier>(),
          gh<_i34.LeaveRepo>(),
          gh<_i19.NotificationService>(),
          gh<_i3.AppFunctions>(),
        ));
    gh.factory<_i45.CreateSpaceBLoc>(() => _i45.CreateSpaceBLoc(
          gh<_i23.SpaceService>(),
          gh<_i26.UserStateNotifier>(),
          gh<_i31.EmployeeService>(),
          gh<_i15.ImagePicker>(),
          gh<_i24.StorageService>(),
        ));
    gh.factory<_i46.DrawerBloc>(() => _i46.DrawerBloc(
          gh<_i23.SpaceService>(),
          gh<_i26.UserStateNotifier>(),
          gh<_i27.AccountService>(),
          gh<_i31.EmployeeService>(),
        ));
    gh.factory<_i47.EmployeeEditProfileBloc>(() => _i47.EmployeeEditProfileBloc(
          gh<_i31.EmployeeService>(),
          gh<_i25.UserPreference>(),
          gh<_i26.UserStateNotifier>(),
          gh<_i24.StorageService>(),
        ));
    gh.lazySingleton<_i48.EmployeeRepo>(
      () => _i48.EmployeeRepo(
        gh<_i31.EmployeeService>(),
        gh<_i26.UserStateNotifier>(),
        gh<_i11.FirebaseCrashlytics>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i49.UserEmployeesBloc>(
        () => _i49.UserEmployeesBloc(gh<_i48.EmployeeRepo>()));
    gh.factory<_i50.UserStateControllerBloc>(() => _i50.UserStateControllerBloc(
          gh<_i48.EmployeeRepo>(),
          gh<_i26.UserStateNotifier>(),
          gh<_i23.SpaceService>(),
          gh<_i22.SpaceChangeNotifier>(),
        ));
    gh.factory<_i51.ViewProfileBloc>(() => _i51.ViewProfileBloc(
          gh<_i26.UserStateNotifier>(),
          gh<_i48.EmployeeRepo>(),
        ));
    gh.factory<_i52.WhoIsOutCardBloc>(() => _i52.WhoIsOutCardBloc(
          gh<_i48.EmployeeRepo>(),
          gh<_i34.LeaveRepo>(),
        ));
    gh.factory<_i53.AdminHomeBloc>(() => _i53.AdminHomeBloc(
          gh<_i34.LeaveRepo>(),
          gh<_i48.EmployeeRepo>(),
        ));
    gh.factory<_i54.AdminLeavesBloc>(() => _i54.AdminLeavesBloc(
          gh<_i34.LeaveRepo>(),
          gh<_i48.EmployeeRepo>(),
        ));
    gh.factory<_i55.AdminMembersBloc>(() => _i55.AdminMembersBloc(
          gh<_i48.EmployeeRepo>(),
          gh<_i16.InvitationService>(),
          gh<_i26.UserStateNotifier>(),
        ));
    gh.factory<_i56.EmployeeDetailBloc>(() => _i56.EmployeeDetailBloc(
          gh<_i27.AccountService>(),
          gh<_i23.SpaceService>(),
          gh<_i26.UserStateNotifier>(),
          gh<_i31.EmployeeService>(),
          gh<_i34.LeaveRepo>(),
          gh<_i48.EmployeeRepo>(),
        ));
    return this;
  }
}

class _$AppModule extends _i57.AppModule {}
