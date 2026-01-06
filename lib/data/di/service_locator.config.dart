// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i141;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:projectunity/app_router.dart' as _i696;
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart'
    as _i811;
import 'package:projectunity/data/bloc/user_state/space_change_notifier.dart'
    as _i232;
import 'package:projectunity/data/bloc/user_state/user_state_controller_bloc.dart'
    as _i576;
import 'package:projectunity/data/core/functions/shared_function.dart' as _i667;
import 'package:projectunity/data/di/app_module.dart' as _i758;
import 'package:projectunity/data/pref/user_preference.dart' as _i161;
import 'package:projectunity/data/provider/device_info.dart' as _i744;
import 'package:projectunity/data/provider/user_state.dart' as _i220;
import 'package:projectunity/data/repo/employee_repo.dart' as _i980;
import 'package:projectunity/data/repo/form_repo.dart' as _i216;
import 'package:projectunity/data/repo/leave_repo.dart' as _i1030;
import 'package:projectunity/data/services/account_service.dart' as _i950;
import 'package:projectunity/data/services/auth_service.dart' as _i95;
import 'package:projectunity/data/services/employee_service.dart' as _i812;
import 'package:projectunity/data/services/form_service.dart' as _i619;
import 'package:projectunity/data/services/invitation_services.dart' as _i910;
import 'package:projectunity/data/services/leave_service.dart' as _i581;
import 'package:projectunity/data/services/mail_notification_service.dart'
    as _i1021;
import 'package:projectunity/data/services/space_service.dart' as _i1052;
import 'package:projectunity/data/services/storage_service.dart' as _i693;
import 'package:projectunity/data/state_manager/auth/desktop/desktop_auth_manager.dart'
    as _i786;
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_bloc.dart'
    as _i298;
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_bloc.dart'
    as _i488;
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart'
    as _i628;
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_bloc.dart'
    as _i837;
import 'package:projectunity/ui/admin/leaves/details/bloc/admin_leave_details_bloc.dart'
    as _i1031;
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart'
    as _i300;
import 'package:projectunity/ui/admin/members/detail/bloc/employee_detail_bloc.dart'
    as _i730;
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_bloc.dart'
    as _i986;
import 'package:projectunity/ui/admin/members/edit_employee/bloc/admin_edit_employee_bloc.dart'
    as _i645;
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart'
    as _i554;
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart'
    as _i1007;
import 'package:projectunity/ui/shared/events/bloc/celebrations_bloc.dart'
    as _i393;
import 'package:projectunity/ui/shared/profile/edit_profile/bloc/employee_edit_profile_bloc.dart'
    as _i864;
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_bloc.dart'
    as _i468;
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_bloc.dart'
    as _i105;
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart' as _i760;
import 'package:projectunity/ui/sign_in/setup_profile/bloc/setup_profile_bloc.dart'
    as _i473;
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart'
    as _i113;
import 'package:projectunity/ui/space/edit_space/bloc/edit_space_bloc.dart'
    as _i872;
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart'
    as _i415;
import 'package:projectunity/ui/user/forms/form_list_screen/bloc/user_forms_list_screen_bloc.dart'
    as _i338;
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart'
    as _i252;
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart'
    as _i823;
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart'
    as _i58;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart'
    as _i698;
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart'
    as _i912;
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_bloc.dart'
    as _i991;
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_bloc.dart'
    as _i273;
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_bloc.dart'
    as _i873;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i667.AppFunctions>(() => _i667.AppFunctions());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.factory<_i895.Connectivity>(() => appModule.connectivity);
    gh.factory<_i183.ImagePicker>(() => appModule.imagePicker);
    gh.factory<_i141.FirebaseCrashlytics>(() => appModule.firebaseCrashlytics);
    gh.factory<_i457.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.factory<_i974.FirebaseFirestore>(() => appModule.firebaseFireStore);
    gh.factory<_i59.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i833.DeviceInfoPlugin>(() => appModule.deviceInfoPlugin);
    gh.factory<_i519.Client>(() => appModule.httpClient);
    gh.factory<_i786.DesktopAuthManager>(() => _i786.DesktopAuthManager());
    gh.lazySingleton<_i232.SpaceChangeNotifier>(
      () => _i232.SpaceChangeNotifier(),
    );
    gh.lazySingleton<_i1021.NotificationService>(
      () => _i1021.NotificationService(
        gh<_i519.Client>(),
        gh<_i141.FirebaseCrashlytics>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i744.DeviceInfoProvider>(
      () => _i744.DeviceInfoProvider(gh<_i833.DeviceInfoPlugin>()),
    );
    gh.factory<_i873.PickImageBloc>(
      () => _i873.PickImageBloc(gh<_i183.ImagePicker>()),
    );
    gh.lazySingleton<_i950.AccountService>(
      () => _i950.AccountService(
        gh<_i974.FirebaseFirestore>(),
        gh<_i744.DeviceInfoProvider>(),
      ),
    );
    gh.lazySingleton<_i161.UserPreference>(
      () => _i161.UserPreference(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i693.StorageService>(
      () => _i693.StorageService(gh<_i457.FirebaseStorage>()),
    );
    gh.factory<_i811.NetworkConnectionBloc>(
      () => _i811.NetworkConnectionBloc(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i910.InvitationService>(
      () => _i910.InvitationService(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i581.LeaveService>(
      () => _i581.LeaveService(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i1052.SpaceService>(
      () => _i1052.SpaceService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i619.FormService>(
      () => _i619.FormService(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i95.AuthService>(
      () => _i95.AuthService(
        gh<_i786.DesktopAuthManager>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i220.UserStateNotifier>(
      () => _i220.UserStateNotifier(
        gh<_i161.UserPreference>(),
        gh<_i232.SpaceChangeNotifier>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.factory<_i216.FormRepo>(
      () => _i216.FormRepo(
        gh<_i220.UserStateNotifier>(),
        gh<_i619.FormService>(),
      ),
    );
    gh.factory<_i872.EditSpaceBloc>(
      () => _i872.EditSpaceBloc(
        gh<_i1052.SpaceService>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i183.ImagePicker>(),
        gh<_i693.StorageService>(),
      ),
    );
    gh.factory<_i760.SignInBloc>(
      () => _i760.SignInBloc(
        gh<_i220.UserStateNotifier>(),
        gh<_i95.AuthService>(),
        gh<_i950.AccountService>(),
      ),
    );
    gh.factory<_i473.SetupProfileBloc>(
      () => _i473.SetupProfileBloc(
        gh<_i950.AccountService>(),
        gh<_i220.UserStateNotifier>(),
      ),
    );
    gh.factory<_i488.AdminFormListBloc>(
      () => _i488.AdminFormListBloc(gh<_i216.FormRepo>()),
    );
    gh.factory<_i338.UserFormListBloc>(
      () => _i338.UserFormListBloc(gh<_i216.FormRepo>()),
    );
    gh.factory<_i696.AppRouter>(
      () => _i696.AppRouter(gh<_i220.UserStateNotifier>()),
    );
    gh.factory<_i298.CreateFormBloc>(
      () => _i298.CreateFormBloc(
        gh<_i216.FormRepo>(),
        gh<_i183.ImagePicker>(),
        gh<_i693.StorageService>(),
        gh<_i220.UserStateNotifier>(),
      ),
    );
    gh.lazySingleton<_i1030.LeaveRepo>(
      () => _i1030.LeaveRepo(
        gh<_i581.LeaveService>(),
        gh<_i220.UserStateNotifier>(),
      ),
    );
    gh.factory<_i698.UserLeaveCountBloc>(
      () => _i698.UserLeaveCountBloc(
        gh<_i1030.LeaveRepo>(),
        gh<_i220.UserStateNotifier>(),
      ),
    );
    gh.lazySingleton<_i812.EmployeeService>(
      () => _i812.EmployeeService(
        gh<_i220.UserStateNotifier>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i113.CreateSpaceBLoc>(
      () => _i113.CreateSpaceBLoc(
        gh<_i1052.SpaceService>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i812.EmployeeService>(),
        gh<_i183.ImagePicker>(),
        gh<_i693.StorageService>(),
      ),
    );
    gh.factory<_i1031.AdminLeaveDetailsBloc>(
      () => _i1031.AdminLeaveDetailsBloc(
        gh<_i1030.LeaveRepo>(),
        gh<_i1021.NotificationService>(),
      ),
    );
    gh.factory<_i645.AdminEditEmployeeDetailsBloc>(
      () => _i645.AdminEditEmployeeDetailsBloc(
        gh<_i812.EmployeeService>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i693.StorageService>(),
      ),
    );
    gh.factory<_i986.AdminEmployeeDetailsLeavesBLoc>(
      () => _i986.AdminEmployeeDetailsLeavesBLoc(gh<_i1030.LeaveRepo>()),
    );
    gh.factory<_i58.UserLeaveDetailBloc>(
      () => _i58.UserLeaveDetailBloc(gh<_i1030.LeaveRepo>()),
    );
    gh.factory<_i991.UserEmployeeDetailBloc>(
      () => _i991.UserEmployeeDetailBloc(gh<_i1030.LeaveRepo>()),
    );
    gh.factory<_i837.InviteMemberBloc>(
      () => _i837.InviteMemberBloc(
        gh<_i910.InvitationService>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i812.EmployeeService>(),
        gh<_i1021.NotificationService>(),
      ),
    );
    gh.factory<_i1007.DrawerBloc>(
      () => _i1007.DrawerBloc(
        gh<_i1052.SpaceService>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i950.AccountService>(),
        gh<_i812.EmployeeService>(),
      ),
    );
    gh.factory<_i823.ApplyLeaveBloc>(
      () => _i823.ApplyLeaveBloc(
        gh<_i220.UserStateNotifier>(),
        gh<_i1030.LeaveRepo>(),
        gh<_i1021.NotificationService>(),
        gh<_i667.AppFunctions>(),
      ),
    );
    gh.factory<_i864.EmployeeEditProfileBloc>(
      () => _i864.EmployeeEditProfileBloc(
        gh<_i812.EmployeeService>(),
        gh<_i161.UserPreference>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i693.StorageService>(),
      ),
    );
    gh.factory<_i252.UserHomeBloc>(
      () => _i252.UserHomeBloc(
        gh<_i220.UserStateNotifier>(),
        gh<_i1030.LeaveRepo>(),
      ),
    );
    gh.factory<_i912.UserLeaveBloc>(
      () => _i912.UserLeaveBloc(
        gh<_i220.UserStateNotifier>(),
        gh<_i1030.LeaveRepo>(),
      ),
    );
    gh.factory<_i415.JoinSpaceBloc>(
      () => _i415.JoinSpaceBloc(
        gh<_i910.InvitationService>(),
        gh<_i1052.SpaceService>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i950.AccountService>(),
        gh<_i812.EmployeeService>(),
        gh<_i95.AuthService>(),
        gh<_i1021.NotificationService>(),
      ),
    );
    gh.factory<_i393.CelebrationsBloc>(
      () => _i393.CelebrationsBloc(gh<_i812.EmployeeService>()),
    );
    gh.lazySingleton<_i980.EmployeeRepo>(
      () => _i980.EmployeeRepo(
        gh<_i812.EmployeeService>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i141.FirebaseCrashlytics>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i273.UserEmployeesBloc>(
      () => _i273.UserEmployeesBloc(gh<_i980.EmployeeRepo>()),
    );
    gh.factory<_i628.AdminHomeBloc>(
      () =>
          _i628.AdminHomeBloc(gh<_i1030.LeaveRepo>(), gh<_i980.EmployeeRepo>()),
    );
    gh.factory<_i468.ViewProfileBloc>(
      () => _i468.ViewProfileBloc(
        gh<_i220.UserStateNotifier>(),
        gh<_i980.EmployeeRepo>(),
      ),
    );
    gh.factory<_i105.WhoIsOutCardBloc>(
      () => _i105.WhoIsOutCardBloc(
        gh<_i980.EmployeeRepo>(),
        gh<_i1030.LeaveRepo>(),
      ),
    );
    gh.factory<_i300.AdminLeavesBloc>(
      () => _i300.AdminLeavesBloc(
        gh<_i1030.LeaveRepo>(),
        gh<_i980.EmployeeRepo>(),
      ),
    );
    gh.factory<_i576.UserStateControllerBloc>(
      () => _i576.UserStateControllerBloc(
        gh<_i980.EmployeeRepo>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i1052.SpaceService>(),
        gh<_i232.SpaceChangeNotifier>(),
      ),
    );
    gh.factory<_i730.EmployeeDetailBloc>(
      () => _i730.EmployeeDetailBloc(
        gh<_i950.AccountService>(),
        gh<_i1052.SpaceService>(),
        gh<_i220.UserStateNotifier>(),
        gh<_i812.EmployeeService>(),
        gh<_i1030.LeaveRepo>(),
        gh<_i980.EmployeeRepo>(),
      ),
    );
    gh.factory<_i554.AdminMembersBloc>(
      () => _i554.AdminMembersBloc(
        gh<_i980.EmployeeRepo>(),
        gh<_i910.InvitationService>(),
        gh<_i220.UserStateNotifier>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i758.AppModule {}
