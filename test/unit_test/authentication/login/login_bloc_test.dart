import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/custom_exception.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/auth_service.dart';
import 'package:projectunity/data/stateManager/auth/auth_manager.dart';
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart';
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_event.dart';
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_state.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthService, AuthManager, UserManager, User,])
void main() {
  late AuthManager authManager;
  late UserManager userManager;
  late AuthService auth;
  late SignInBloc signInBloc;
  late User user;
  late String userEmail = "dummy123@testing.com";

  Employee employee = const Employee(
      id: 'id',
      roleType: 1,
      name: 'Andrew jhone',
      employeeId: '100',
      email: 'dummy123@testing.com',
      designation: 'Android developer');

  setUp(() {
    authManager = MockAuthManager();
    userManager = MockUserManager();
    user = MockUser();
    auth = MockAuthService();
    signInBloc = SignInBloc(authManager, userManager, auth);
    when(auth.signInWithGoogle()).thenAnswer((_) async => Future(() => user));
    when(user.email).thenReturn(userEmail);
  });

  group("Login in test", () {
    test(
        "after login successfully, employee has been not null in user manager ",
        () async {
      when(userManager.isAdmin).thenReturn(false);
      when(authManager.getUser(userEmail))
          .thenAnswer((realInvocation) async => employee);
      signInBloc.add(SignInEvent());
      expect(
          signInBloc.stream,
          emitsInOrder([
            SignInLoadingState(),
            SignInSuccessState(),
          ]));
      await untilCalled(userManager.hasLoggedIn());
      verify(userManager.hasLoggedIn()).called(1);
    });

    test("user not found test", () {
      when(authManager.getUser(userEmail))
          .thenAnswer((realInvocation) async => Future(() => null));
      signInBloc.add(SignInEvent());
      expect(
          signInBloc.stream,
          emitsInOrder([
            SignInLoadingState(),
            SignInFailureState(error: userNotFoundError),
          ]));
    });

    test("user data update to fail test", () {
      when(authManager.updateUser(employee))
          .thenThrow(Exception("data not valid"));
      when(authManager.getUser(userEmail))
          .thenAnswer((realInvocation) async => Future(() => employee));
      signInBloc.add(SignInEvent());
      expect(
          signInBloc.stream,
          emitsInOrder([
            SignInLoadingState(),
            SignInFailureState(error: userDataNotUpdateError),
          ]));
    });

    test("custom exception thrown", () {
      when(auth.signInWithGoogle())
          .thenThrow(CustomException(firesbaseAuthError));
      signInBloc.add(SignInEvent());
      expect(
          signInBloc.stream,
          emitsInOrder([
            SignInLoadingState(),
            SignInFailureState(error: firesbaseAuthError),
            SignInInitialState()
          ]));
    });
  });
}
