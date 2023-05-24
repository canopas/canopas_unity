import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
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
  final UserStateNotifier _userManager;
  final AuthService _authService;
  final AccountService _accountService;

  SignInBloc(
    this._userManager,
    this._authService,
    this._accountService,
  ) : super(SignInInitialState()) {
    on<SignInEvent>(_signIn);
  }

  Future<void> _signIn(SignInEvent event, Emitter<SignInState> emit) async {
    emit(SignInLoadingState());
    try {
      firebase_auth.User? authUser = await _authService.signInWithGoogle();
      if (authUser != null) {
        final Account user = await _accountService.getUser(authUser);
        await _userManager.setUser(user);
        emit(SignInSuccessState());
      } else {
        emit(SignInInitialState());
      }
    } on Exception {
      emit(SignInFailureState(error: firesbaseAuthError));
    }
  }
}
