import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/services/account_service.dart';
import '../../../data/core/exception/error_const.dart';
import '../../../data/model/account/account.dart';
import '../../../data/provider/user_state.dart';
import '../../../data/services/auth_service.dart';
import 'sign_in_view_event.dart';
import 'sign_in_view_state.dart';

@Injectable()
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserStateNotifier _userStateNotifier;
  final AuthService _authService;
  final AccountService _accountService;

  SignInBloc(
    this._userStateNotifier,
    this._authService,
    this._accountService,
  ) : super(const SignInState()) {
    on<GoogleSignInEvent>(_googleSignIn);
    on<AppleSignInEvent>(_appleSignIn);
  }

  Future<void> _googleSignIn(
      SignInEvent event, Emitter<SignInState> emit) async {
    try {
      emit(state.copyWith(googleSignInLoading: true));
      firebase_auth.User? authUser = await _authService.signInWithGoogle();
      if (authUser != null) {
        final Account user = await _accountService.getUser(authUser);
        await _userStateNotifier.setUser(user);
        emit(state.copyWith(googleSignInLoading: false, signInSuccess: true));
      } else {
        emit(state.copyWith(googleSignInLoading: false));
      }
    } on Exception {
      emit(state.copyWith(
          googleSignInLoading: false, error: firesbaseAuthError));
    }
  }

  Future<void> _appleSignIn(
      AppleSignInEvent event, Emitter<SignInState> emit) async {
    try {
      emit(state.copyWith(appleSignInLoading: true));
      firebase_auth.User? authUser = await _authService.signInWithApple();
      if (authUser != null) {
        final Account? user = await _accountService.getAppleUser(authUser);
        if (user == null) {
          emit(state.copyWith(
              appleSignInLoading: false,
              error: appleSigninError,
              firebaseAuthUser: authUser));
          return;
        }
        await _userStateNotifier.setUser(user);
        emit(state.copyWith(appleSignInLoading: false, signInSuccess: true));
      } else {
        emit(state.copyWith(appleSignInLoading: false));
      }
    } catch (e, stack) {
      if (e is FirebaseAuthException && e.code == 'canceled') {
        emit(state.copyWith(appleSignInLoading: false));
        return;
      }
      FirebaseCrashlytics.instance
          .recordError(e, stack, reason: 'Apple Sign In Error');
      emit(state.copyWith(
          appleSignInLoading: false, error: somethingWentWrongError));
    }
  }
}
