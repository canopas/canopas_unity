import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:uuid/uuid.dart';
import '../../../data/core/exception/custom_exception.dart';
import '../../../data/core/exception/error_const.dart';
import '../../../data/provider/user_data.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/stateManager/auth/auth_manager.dart';
import 'sign_in_view_event.dart';
import 'sign_in_view_state.dart';

@Injectable()
class SignInScreenBloc extends Bloc<SignInEvents, SignInState> {
  final AuthManager _authManager;
  final UserManager _userManager;
  final AuthService _authService;
  final Uuid _uuid;

  SignInScreenBloc(
    this._authManager,
    this._userManager,
    this._authService, this._uuid,
  ) : super(SignInInitialState()) {
    on<SignInEvent>(_signIn);
    on<CreateSpaceSignInEvent>(_createSpaceSignIn);
  }

  Future<void> _signIn(
      SignInEvent event, Emitter<SignInState> emit) async {
    User? user;
    emit(SignInLoadingState());
    try {
      user = await _authService.signInWithGoogle();
    } on CustomException catch (error) {
      emit(SignInScreenFailureState(error: error.errorMessage.toString()));
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
          emit(SignInScreenFailureState(error: userNotFoundError));
        }
      } on Exception {
        emit(SignInScreenFailureState(error: userDataNotUpdateError));
      }
    }
  }

  Future<void> _createSpaceSignIn(
      CreateSpaceSignInEvent event, Emitter<SignInState> emit) async {
    User? user;
    emit(SignInLoadingState());
    try {
      user = await _authService.signInWithGoogle();
      if (user == null) {
        emit(SignInInitialState());
      } else {
        emit(CreateSpaceSignInSuccessState(Employee(
          id: _uuid.v4(),
          roleType: 1,
          name: user.displayName ?? "",
          employeeId: "",
          email: user.email!,
          designation: "",
        )));
      }
    } on CustomException catch (error) {
      emit(SignInScreenFailureState(error: error.errorMessage.toString()));
    }
  }
}
