import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/navigation/nav_stack_item.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../exception/error_const.dart';
import '../../navigation/navigation_stack_manager.dart';

@Injectable()
class LogOutBloc extends BaseBLoc {
  final UserPreference _userPreference;
  final NavigationStackManager _navigationStackManager;

  LogOutBloc(this._userPreference, this._navigationStackManager);

  final BehaviorSubject<ApiResponse<bool>> _signOutSubject =
      BehaviorSubject<ApiResponse<bool>>();

  Stream<ApiResponse<bool>> get signOutResponse => _signOutSubject.stream;

  Future<void> signOutFromApp() async {
    _signOutSubject.add(const ApiResponse.loading());
    bool success = await _signOut();
    if (success) {
      _signOutSubject.add(const ApiResponse.completed(data: true));
      _navigationStackManager.clearAndPush(const LoginNavStackItem());
    } else {
      _signOutSubject.add(const ApiResponse.error(error: signOutError));
    }
  }

  Future<bool> _signOut() async {
    bool isLogOut = await _signOutWithGoogle();
    if (isLogOut) {
      await _userPreference.removeCurrentUser();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _signOutWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      final FirebaseAuth auth = FirebaseAuth.instance;
      await googleSignIn.signOut();
      await auth.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  void detach() {
    _signOutSubject.close();
  }

  @override
  void attach() {}
}
