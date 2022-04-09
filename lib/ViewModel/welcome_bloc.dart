import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ViewModel/login_bloc.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class WelcomeBloc {
  late GoogleSignInAccount? currentUSer;

  final _hasAccount = PublishSubject<ApiResponse<GoogleSignInAccount?>>();

  PublishSubject<ApiResponse<GoogleSignInAccount?>> get account => _hasAccount;

  setAccount() async {
    _hasAccount.sink.add(const ApiResponse.loading());

    currentUSer = await googleSignIn.signInSilently();
    _hasAccount.sink.add(ApiResponse.completed(data: currentUSer));

    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      currentUSer = account;
      _hasAccount.sink.add(ApiResponse.completed(data: currentUSer));
    });
  }
}
