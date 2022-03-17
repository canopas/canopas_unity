import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/ViewModel/api_response.dart';
import 'package:projectunity/ViewModel/login_bloc.dart';
import 'package:projectunity/Widget/error_banner.dart';
import 'package:projectunity/ui/User/home_screen.dart';
import 'package:projectunity/utils/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = getIt<LoginBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
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
                    onPressed: () async {
                      try {
                        await _bloc.isSignedIn();
                      } catch (error) {
                        SchedulerBinding.instance?.addPostFrameCallback(
                            (_) => showErrorBanner(error.toString(), context));
                      }
                    },
                    child: StreamBuilder<ApiResponse<bool>>(
                        stream: _bloc.loginResponse,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              switch (snapshot.data!.status) {
                                case Status.loading:
                                  return const CircularProgressIndicator();
                                case Status.completed:
                                  var success = snapshot.data?.data ?? true;
                                  if (success) {
                                    SchedulerBinding.instance
                                        ?.addPostFrameCallback((_) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()));
                                    });
                                  }
                                  break;
                                case Status.error:
                                  SchedulerBinding.instance
                                      ?.addPostFrameCallback((_) =>
                                          showErrorBanner(
                                              snapshot.error.toString(),
                                              context));
                              }
                            }
                          }
                          if (snapshot.hasError) {
                            SchedulerBinding.instance?.addPostFrameCallback(
                              (_) => showErrorBanner(
                                  snapshot.error.toString(), context),
                            );
                          }
                          return Padding(
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
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 25)),
                              ],
                            ),
                          );
                        }),
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
