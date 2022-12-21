import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/custom_exception.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/auth/auth_service.dart';
import 'package:projectunity/stateManager/auth/auth_manager.dart';
import 'package:projectunity/ui/login/bloc/login_view_bloc.dart';
import 'package:projectunity/ui/login/bloc/login_view_event.dart';
import 'package:projectunity/ui/login/bloc/login_view_state.dart';
import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthService,AuthManager,UserManager,NavigationStackManager,User])
void main(){

  late AuthManager authManager;
  late UserManager userManager;
  late NavigationStackManager navigationStackManager;
  late AuthService auth;
  late LoginBloc loginBloc;
  late User user;
  late String userEmail= "dummy123@testing.com";

  Employee employee = const Employee(
      id: 'id',
      roleType: 1,
      name: 'Andrew jhone',
      employeeId: '100',
      email: 'dummy123@testing.com',
      designation: 'Android developer');

  setUpAll(() {
    authManager = MockAuthManager();
    userManager = MockUserManager();
    navigationStackManager = MockNavigationStackManager();
    user = MockUser();
    auth = MockAuthService();
    loginBloc = LoginBloc(authManager, userManager, navigationStackManager, auth);
    when(auth.signInWithGoogle()).thenAnswer((_) async => Future(() => user));
    when(user.email).thenReturn(userEmail);
  });

  group("Login in test", () {
    test("after login successful navigate to employee home test ", () async {
      when(userManager.isAdmin).thenReturn(false);
      when(authManager.getUser(userEmail)).thenAnswer((realInvocation) async => employee);
      loginBloc.add(SignInEvent());
      expect(loginBloc.stream, emitsInOrder([
        LoginLoadingState(),
        LoginSuccessState(),
      ]));
      const state = EmployeeHomeNavStackItem();
      await untilCalled(navigationStackManager.clearAndPush(state));
      verify(navigationStackManager.clearAndPush(state)).called(1);
    });

    test("after login successful navigate to admin home test", () async {
      when(userManager.isAdmin).thenReturn(true);
      when(authManager.getUser(userEmail)).thenAnswer((realInvocation) async => employee);
      loginBloc.add(SignInEvent());
      expect(loginBloc.stream, emitsInOrder([
        LoginLoadingState(),
        LoginSuccessState(),
      ]));
      const state = AdminHomeNavStackItem();
      await untilCalled(navigationStackManager.clearAndPush(state));
      verify(navigationStackManager.clearAndPush(state)).called(1);
    });

    test("user not found test", (){
      when(authManager.getUser(userEmail)).thenAnswer((realInvocation) async => Future(() => null));
      loginBloc.add(SignInEvent());
      expect(loginBloc.stream, emitsInOrder([
        LoginLoadingState(),
        LoginFailureState(error: userNotFoundError),
      ]));
    });

    test("user data update to fail test", (){
      when(authManager.updateUser(employee)).thenThrow(Exception("data not valid"));
      when(authManager.getUser(userEmail)).thenAnswer((realInvocation) async => Future(() => employee));
      loginBloc.add(SignInEvent());
      expect(loginBloc.stream, emitsInOrder([
        LoginLoadingState(),
        LoginFailureState(error: userDataNotUpdateError),
      ]));
    });

    test("custom exception thrown", (){
      when(auth.signInWithGoogle()).thenThrow(CustomException(firesbaseAuthError));
      loginBloc.add(SignInEvent());
      expect(loginBloc.stream, emitsInOrder([
        LoginLoadingState(),
        LoginFailureState(error: firesbaseAuthError),
        LoginInitialState()
      ]));
    });
  });
}