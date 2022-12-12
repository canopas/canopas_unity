import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/bloc/authentication/logout_bloc.dart';
import 'package:projectunity/bloc/authentication/logout_event.dart';
import 'package:projectunity/bloc/authentication/logout_state.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/services/auth/auth_service.dart';

import 'logout_bloc _test.mocks.dart';

@GenerateMocks([AuthService,UserPreference,NavigationStackManager])
void main(){
  late UserPreference userPreference;
  late NavigationStackManager navigationStackManager;
  late AuthService auth;
  late LogOutBloc logOutBloc;

  setUpAll((){
    userPreference = MockUserPreference();
    navigationStackManager =MockNavigationStackManager();
    auth = MockAuthService();
    logOutBloc =LogOutBloc(navigationStackManager, userPreference, auth);
    when(userPreference.removeCurrentUser()).thenAnswer((realInvocation) => Future(() => true));
  });

  group("sign out test", () {
    test("login signOut successful test with navigation test", () async {
      when(auth.signOutWithGoogle()).thenAnswer((realInvocation) => Future(() => true));
      logOutBloc.add(SignOutEvent());
      expect(logOutBloc.stream, emitsInOrder([
        LogOutLoadingState(),
        LogOutSuccessState(),
      ]));
      const state = LoginNavStackItem();
      await untilCalled(navigationStackManager.clearAndPush(state));
      verify(navigationStackManager.clearAndPush(state)).called(1);
    });

    test("signOut failure test", (){
      when(auth.signOutWithGoogle()).thenAnswer((realInvocation) => Future(() => false));
      logOutBloc.add(SignOutEvent());
      expect(logOutBloc.stream, emitsInOrder([
        LogOutLoadingState(),
        LogOutFailureState(error: signOutError),
      ]));
    });
  });
}