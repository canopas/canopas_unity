import 'package:flutter/material.dart';
import 'package:projectunity/services/handle_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SignIn signIn = SignIn();

  @override
  void initState() {
    super.initState();
    googleSignIn.signInSilently();
    googleSignIn.onCurrentUserChanged.listen((event) {
      if (event != null) {
        print('user successfully logged in !');
      } else {
        throw Exception('user not found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/home_page_image.png',
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                  child: Text(
                    'To Continue with Unity please login here...',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: OutlinedButton(
                    style: TextButton.styleFrom(
                        side: const BorderSide(color: Colors.grey, width: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                    onPressed: () => signIn.handleSignIn(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Image.asset(
                            'assets/images/google_logo.png',
                            fit: BoxFit.cover,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Sign in with Google',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 25)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
