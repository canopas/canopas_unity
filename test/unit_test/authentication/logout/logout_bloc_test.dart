import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/bloc/authentication/logout_bloc.dart';
import 'package:projectunity/bloc/authentication/logout_event.dart';
import 'package:projectunity/bloc/authentication/logout_state.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/auth/auth_service.dart';
import 'logout_bloc_test.mocks.dart';


@GenerateMocks([AuthService,UserPreference,UserManager])
void main(){
  late UserPreference userPreference;
  late AuthService auth;
  late LogOutBloc logOutBloc;
  late UserManager userManager;

  setUpAll((){
    userPreference = MockUserPreference();
    auth = MockAuthService();
    userManager= MockUserManager();
    logOutBloc =LogOutBloc(userPreference, auth,userManager);
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
      await untilCalled(userManager.hasLoggedIn());
      verify(userManager.hasLoggedIn()).called(1);
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