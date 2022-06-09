import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/login_state.dart';
import 'package:projectunity/ui/login/widget/widget_sign_in_button.dart';
import 'package:projectunity/widget/app_circular_indicator.dart';

import '../../configs/colors.dart';
import '../../rest/api_response.dart';
import '../../utils/const/image_constant.dart';
import '../../viewmodel/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = getIt<LoginBloc>();
  final _loginState = getIt<LoginState>();

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
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(loginPageBackgroundImage),
                fit: BoxFit.cover)),
        child: Scaffold(
            body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Column(
                        children: [
                          buildTitle(),
                          buildSubTitle(),
                        ],
                      ),
                    ),
                    buildImage(context),
                    Column(children: [
                      const Center(
                        child: Text(
                          'To continue with Unity please',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      StreamBuilder<ApiResponse<bool>>(
                          stream: _bloc.loginResponse,
                          initialData: const ApiResponse.idle(),
                          builder: (context, snapshot) {
                            return snapshot.data!.when(idle: () {
                              return SignInButton(
                                onPressed: () => _bloc.signIn(),
                              );
                            }, loading: () {
                              return const AppCircularIndicator();
                            }, completed: (bool hasAccount) {
                              if (hasAccount) {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  _loginState.setUserLogin(hasAccount);
                                });
                              }
                              return Container();
                            }, error: (String error) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                final snackBar = SnackBar(
                                  backgroundColor: AppColors.redColor,
                                  content: Text(error),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                _bloc.reset();
                              });
                              return Container();
                            });
                          })
                    ]),
                  ]),
            ),
          ),
        )));
  }
}

Container buildImage(BuildContext context) {
  return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            loginPageVectorImage,
          ),
        ),
      ));
}

Text buildSubTitle() {
    return const Text(
      'to Unity!',
      style: TextStyle(
          fontSize: 50, letterSpacing: 1, color: Colors.black87, height: 1),
    );
  }

  Text buildTitle() {
    return const Text(
      'Welcome',
      style: TextStyle(fontSize: 50, color: Colors.black87, height: 2),
    );
  }
