import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/login/widget/widget_sign_in_button.dart';
import 'package:projectunity/utils/const/color_constant.dart';

import '../../bloc/login_bloc.dart';
import '../../rest/api_response.dart';
import '../../stateManager/login_state.dart';
import '../../utils/const/image_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = getIt<LoginBloc>();
  final _loginState = getIt<LoginState>();
  bool _showProrgress = false;

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
              image: AssetImage(loginPageBackgroundImage), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder<ApiResponse<bool>>(
            stream: _bloc.loginResponse,
            initialData: const ApiResponse.idle(),
            builder: (context, snapshot) {
              snapshot.data!.when(
                  idle: () {},
                  loading: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _showProrgress = true;
                      });
                    });
                  },
                  completed: (bool hasAccount) {
                    if (hasAccount) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _showProrgress = false;
                        });
                        _loginState.setUserLogin(hasAccount);
                      });
                    }
                  },
                  error: (String error) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _showProrgress = false;
                      });
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
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
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      _bloc.reset();
                    });
                  });

              return SingleChildScrollView(
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            _showProrgress
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Color(kPrimaryColour)))
                                : SignInButton(onPressed: _bloc.signIn),
                          ]),
                        ]),
                  ),
                ),
              );
            }),
      ),
    );
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
    return Text(
      'to Unity!',
      style: GoogleFonts.ibmPlexSans(
          fontSize: 50, letterSpacing: 1, color: Colors.black87, height: 1),
    );
  }

  Text buildTitle() {
    return Text(
      'Welcome',
      style: GoogleFonts.ibmPlexSans(
          height: 2,
          fontSize: 50,
          color: Colors.black87,
          fontStyle: FontStyle.italic),
    );
  }
}
