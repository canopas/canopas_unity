import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../data/core/exception/custom_exception.dart';
import '../../../data/core/exception/error_const.dart';
import '../../../data/provider/user_data.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/stateManager/auth/auth_manager.dart';
import 'sign_in_view_event.dart';
import 'sign_in_view_state.dart';

@Injectable()
class SignInScreenBloc extends Bloc<SignInEvent, SignInState> {
  final AuthManager _authManager;
  final UserManager _userManager;
  final AuthService _authService;

  SignInScreenBloc(
    this._authManager,
    this._userManager,
    this._authService,
  ) : super(SignInInitialState()) {
    on<SignInEvent>(_signIn);
  }

  Future<void> _signIn(
      SignInEvent event, Emitter<SignInState> emit) async {
    User? user;
    emit(SignInLoadingState());
    try {
      user = await _authService.signInWithGoogle();
    } on CustomException catch (error) {
      emit(SignInFailureState(error: error.errorMessage.toString()));
    }
    if (user == null) {
      emit(SignInInitialState());
    } else {
      final data = await _authManager.getUser(user.email!);
      try {
        if (data != null) {
          await _authManager.updateUser(data);
          emit(SignInSuccessState());
          _userManager.hasLoggedIn();
        } else {
          emit(SignInFailureState(error: userNotFoundError));
        }
      } on Exception {
        emit(SignInFailureState(error: userDataNotUpdateError));
      }
    }
  }
}
