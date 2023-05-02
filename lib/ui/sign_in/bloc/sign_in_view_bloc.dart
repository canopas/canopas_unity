import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../data/core/exception/custom_exception.dart';
import '../../../data/model/user/user.dart';
import '../../../data/provider/user_data.dart';
import '../../../data/services/auth_service.dart';
import 'sign_in_view_event.dart';
import 'sign_in_view_state.dart';

@Injectable()
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserManager _userManager;
  final AuthService _authService;

  SignInBloc(
    this._userManager,
    this._authService,
  ) : super(SignInInitialState()) {
    on<SignInEvent>(_signIn);
  }

  Future<void> _signIn(SignInEvent event, Emitter<SignInState> emit) async {
    emit(SignInLoadingState());
    try {
      firebase_auth.User? authUser = await _authService.signInWithGoogle();
      if (authUser != null) {
        final User user = await _authService.getUser(authUser);
        await _userManager.setUser(user);
        emit(SignInSuccessState());
      } else {
        emit(SignInInitialState());
      }
    } on CustomException catch (error) {
      emit(SignInFailureState(error: error.errorMessage.toString()));
    }
  }
}
