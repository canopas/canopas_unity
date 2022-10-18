import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/stateManager/auth/auth_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../exception/custom_exception.dart';
import '../../exception/error_const.dart';

@Injectable()
class LoginBloc extends BaseBLoc {
  final AuthManager _authManager;
  final UserManager _userManager;

  final NavigationStackManager _navigationStackManager;

  LoginBloc(this._authManager, this._navigationStackManager, this._userManager);

  final _loginSubject = BehaviorSubject<ApiResponse<bool>>();

  BehaviorSubject<ApiResponse<bool>> get loginResponse => _loginSubject;

  Future<void> signIn() async {
    _loginSubject.add(const ApiResponse.loading());

    try {
      User? user = await _signInWithGoogle();
      if (user == null) {
        _loginSubject.add(const ApiResponse.completed(data: false));
      } else {
        final data = await _authManager.getUser(user.email!);
        try {
          if (data != null) {
            await _authManager.updateUser(data);
            _loginSubject.add(const ApiResponse.completed(data: true));
            if (_userManager.isAdmin) {
              _navigationStackManager
                  .clearAndPush(const AdminHomeNavStackItem());
            } else {
              _navigationStackManager
                  .clearAndPush(const EmployeeHomeNavStackItem());
            }
          } else {
            _loginSubject
                .add(const ApiResponse.error(error: userNotFoundError));
          }
        } on Exception {
          _loginSubject
              .add(const ApiResponse.error(error: userDataNotUpdateError));
        }
      }
    } on Exception catch (error) {
      _loginSubject.add(ApiResponse.error(error: error.toString()));
    }
  }

  Future<User?> _signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException {
        throw CustomException(firesbaseAuthError);
      }
    }
    return user;
  }

  void reset() {
    _loginSubject.sink.add(const ApiResponse.idle());
  }

  @override
  void attach() {}

  @override
  void detach() {
    _loginSubject.close();
  }
}
