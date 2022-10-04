import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectunity/l10n/l10n.dart';
import 'package:projectunity/stateManager/login_state_manager.dart';
import 'package:projectunity/ui/app_dashboard_screen.dart';
import 'package:projectunity/ui/login/login_screen.dart';
import 'package:projectunity/ui/onboard/onboard_screen.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import 'bloc/network/network_service_bloc.dart';
import 'configs/theme.dart';
import 'di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies();
  runApp(
    MaterialApp(
      theme: AppTheme.lightTheme,
      title: 'ProjectUnity Flutter',
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MyApp(),
    ),
  );
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    String error = flutterErrorDetails.exceptionAsString();
    return ErrorScreen(error: error);
  };
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _loginState = getIt<LoginState>();
  final _networkServiceBloc = getIt<NetworkServiceBloc>();
  late bool isLogin;
  late bool isOnBoardComplete;

  @override
  void initState() {
    _networkServiceBloc.getConnectivityStatus();
    isLogin = _loginState.isLogin;
    isOnBoardComplete = _loginState.onBoardComplete;
    _loginState.addListener(() {
      setState(() {
        isLogin = _loginState.isLogin;
        isOnBoardComplete = _loginState.onBoardComplete;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _networkServiceBloc.connection,
        builder: (context, snapshot) {
          String networkErrorMsg =
              AppLocalizations.of(context).check_your_connection_error;
          snapshot.data == false
              ? Fluttertoast.showToast(msg: networkErrorMsg)
              : null;
          return Navigator(
              pages: [
                if (!isOnBoardComplete)
                  const MaterialPage(child: OnBoardScreen()),
                if (isOnBoardComplete && !isLogin)
                  const MaterialPage(child: LoginScreen()),
                if (isOnBoardComplete && isLogin)
                  const MaterialPage(child: AppDashboardScreen()),
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result)) {
                  return false;
                }
                return true;
              });
        });
  }
}
