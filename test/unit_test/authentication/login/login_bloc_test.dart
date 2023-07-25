import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/model/account/account.dart';
import 'package:projectunity/data/provider/user_status_notifier.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/auth_service.dart';
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_bloc.dart';
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_event.dart';
import 'package:projectunity/ui/sign_in/bloc/sign_in_view_state.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([
  AuthService,
  AccountService,
  UserStatusNotifier,
  firebase_auth.User,
])
void main() {
  late UserStatusNotifier userStateNotifier;
  late AuthService authService;
  late AccountService accountService;

  late SignInBloc bloc;
  late firebase_auth.User authUser;

  const Account user = Account(uid: 'uid', email: "dummy@canopas.com");

  setUp(() {
    userStateNotifier = MockUserStateNotifier();
    authUser = MockUser();
    authService = MockAuthService();
    accountService = MockAccountService();
    bloc = SignInBloc(userStateNotifier, authService, accountService);
  });

  group("Log in with google test", () {
    test("Set initial state on cancel login test", () async {
      when(authService.signInWithGoogle()).thenAnswer((_) async => null);
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
      when(authService.signInWithGoogle()).thenAnswer((_) async => authUser);
      when(accountService.getUser(authUser)).thenAnswer((_) async => user);
      bloc.add(SignInEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            SignInLoadingState(),
            SignInSuccessState(),
          ]));
      await untilCalled(userStateNotifier.setUser(user));
      verify(userStateNotifier.setUser(user)).called(1);
    });
  });
}
