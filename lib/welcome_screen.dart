import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/ui/User/Employee/employee_list_screen.dart';
import 'package:projectunity/ui/login/login_screen.dart';
import 'ViewModel/welcome_bloc.dart';
import 'Widget/error_banner.dart';
import 'di/service_locator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _bloc = getIt<WelcomeBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.setAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ApiResponse<GoogleSignInAccount?>>(
          initialData: const ApiResponse.idle(),
          stream: _bloc.account,
          builder: (context, snapshot) {
            snapshot.data?.when(idle: () {
              return Container();
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }, completed: (account) {
              if (account == null) {
                SchedulerBinding.instance?.addPostFrameCallback((_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                });
              } else {
                SchedulerBinding.instance?.addPostFrameCallback((_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmployeeListScreen()));
                });
              }
              return Container();
            }, error: (error) {
              showErrorBanner(error.toString(), context);
            });
            return Container();
          }),
    );
  }
}
