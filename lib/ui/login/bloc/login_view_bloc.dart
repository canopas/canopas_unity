
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/custom_exception.dart';
import 'package:projectunity/services/auth/auth_service.dart';
import 'package:projectunity/ui/login/bloc/login_view_event.dart';
import '../../../exception/error_const.dart';
import '../../../provider/user_data.dart';
import '../../../stateManager/auth/auth_manager.dart';
import 'login_view_state.dart';

@Injectable()
class LoginBloc extends Bloc<SignInEvent, LoginState> {
  final AuthManager _authManager;
  final UserManager _userManager;
  final AuthService _authService;

  LoginBloc(this._authManager, this._userManager, this._authService,)
      : super(LoginInitialState()) {
    on<SignInEvent>(_signIn);
  }

 Future<void> _signIn(SignInEvent event, Emitter<LoginState> emit) async {
    User? user;
    emit(LoginLoadingState());
    try {
      user = await _authService.signInWithGoogle();
    } on CustomException catch (error) {
      emit(LoginFailureState(error: error.errorMessage.toString()));
    }
    if (user == null) {
      emit(LoginInitialState());

    } else {
      final data = await _authManager.getUser(user.email!);
      try {
        if (data != null) {
          await _authManager.updateUser(data);
          emit(LoginSuccessState());
          _userManager.hasLoggedIn();
        } else {
          emit(LoginFailureState(error: userNotFoundError));
        }
      } on Exception {
        emit(LoginFailureState(error: userDataNotUpdateError));
      }
    }
  }



}
