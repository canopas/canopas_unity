import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/di/service_locator.dart';

import '../../ViewModel/login_bloc.dart';
import '../../Widget/error_banner.dart';
import '../../rest/api_response.dart';
import '../../utils/Constant/color_constant.dart';
import '../../utils/Constant/image_constant.dart';

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
    return SafeArea(
        child: Scaffold(
            body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(loginPageBackgroundImage), fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: GoogleFonts.sourceSans3(
                        height: 2,
                        fontSize: 50,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'to Unity!',
                    style: GoogleFonts.sourceSans3(
                        // fontStyle: FontStyle.italic,
                        fontSize: 50,
                        letterSpacing: 1,
                        color: Colors.black87,
                        height: 0.7),
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      loginPageVectorImage,
                    ),
                  ),
                )),
            Column(children: [
              const Center(
                child: Text(
                  'To continue with Unity please',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<ApiResponse<bool>>(
                  stream: _bloc.loginResponse,
                  initialData: const ApiResponse.idle(),
                  builder: (context, snapshot) {
                    return snapshot.data!.when(idle: () {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 50,
                          child: TextButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                  const BorderSide(
                                      color: Color(kPrimaryColour), width: 2),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(kSecondaryColor).withOpacity(0.2),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                overlayColor: MaterialStateProperty.all(
                                    const Color(kPrimaryColour)
                                        .withOpacity(0.2)),
                              ),
                              onPressed: () {
                                _bloc.signInWithGoogle();
                              },
                              child: Row(children: [
                                Image.asset(
                                  googleLogoImage,
                                  height: 40,
                                ),
                                const Expanded(
                                  child: Text(
                                    'Sign in with Google',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 20),
                                  ),
                                )
                              ])));
                    }, loading: () {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(kPrimaryColour),
                        ),
                      );
                    }, completed: (bool hasAccount) {
                      if (hasAccount) {
                        SchedulerBinding.instance?.addPostFrameCallback((_) {
                          Navigator.pushNamed(context, '/homeScreen');
                        });
                      }
                      return Container();
                    }, error: (String error) {
                      SchedulerBinding.instance?.addPostFrameCallback((_) {
                        showErrorBanner(error, context);
                      });

                      return Container();
                    });
                  }),
            ]),
          ]),
        ),
      ),
    )));
  }
}
