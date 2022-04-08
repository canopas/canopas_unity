import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectunity/rest/api_response.dart';

import 'ViewModel/login_bloc.dart';
import 'Widget/error_banner.dart';
import 'di/service_locator.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _bloc = getIt<LoginBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<GoogleSignInAccount?>>(
        stream: _bloc.loginResponse,
        initialData: const ApiResponse.idle(),
        builder: (context, snapshot) {
          print('rootScreen: ' + snapshot.data.toString());
          return snapshot.data!.when(idle: () {
            return Container();
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, completed: (account) {
            if (account != null) {
              print('user has been navigate to homeScreen');
              SchedulerBinding.instance?.addPostFrameCallback((_) {
                Navigator.pushNamed(context, '/homeScreen');
              });
            } else {
              SchedulerBinding.instance?.addPostFrameCallback((_) {
                Navigator.pushNamed(context, '/loginScreen');
              });
            }
            return Container();
          }, error: (String error) {
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              showErrorBanner(error, context);
            });

            return Container();
          });
        });
  }
}
