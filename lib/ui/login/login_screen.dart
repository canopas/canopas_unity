import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectunity/ViewModel/login_vm.dart';
import 'package:projectunity/utils/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
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
                    onPressed: () {
                      try {
                        getIt<LoginVM>().signInWithGoogle();
                      } on Exception catch (error) {
                        showAlertDialog(context, error.toString());
                      }
                    },
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

  Widget showAlertDialog(BuildContext context, String message) {
    AlertDialog dialog = AlertDialog(
      title: const Text('Google sign in failed!!'),
      content: Text(message),
      elevation: 5,
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: const Text('Ok'))
      ],
    );
    return dialog;
  }
}
