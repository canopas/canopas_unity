import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/model/account/account.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/auth_service.dart';
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart';
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_event.dart';
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_state.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([
  AuthService,
  AccountService,
  UserManager,
  firebase_auth.User,
])
void main() {
  late UserManager userManager;
  late AuthService authService;
  late AccountService accountService;

  late SignInBloc bloc;
  late firebase_auth.User authUser;

  const Account user = Account(uid: 'uid', email: "dummy@canopas.com");

  setUp(() {
    userManager = MockUserManager();
    authUser = MockUser();
    authService = MockAuthService();
    accountService = MockAccountService();
    bloc = SignInBloc(userManager, authService, accountService);
  });

  group("Log in with google test", () {
    test("Set initial state on cancel login test", () async {
      when(authService.signInWithGoogle())
          .thenAnswer((realInvocation) async => null);
      bloc.add(SignInEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            SignInLoadingState(),
            SignInInitialState(),
          ]));
    });

    test("Login success test", () async {
      when(authUser.uid).thenAnswer((realInvocation) => user.uid);
      when(authUser.email).thenAnswer((realInvocation) => user.email);
      when(authService.signInWithGoogle())
          .thenAnswer((realInvocation) async => authUser);
      when(accountService.getUser(authUser))
          .thenAnswer((realInvocation) async => user);
      bloc.add(SignInEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            SignInLoadingState(),
            SignInSuccessState(),
          ]));
      await untilCalled(userManager.setUser(user));
      verify(userManager.setUser(user)).called(1);
    });
  });
}
