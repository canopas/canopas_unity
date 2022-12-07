import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projectunity/bloc/network/network_Connection_event.dart';
import 'package:projectunity/bloc/network/network_connection_bloc.dart';
import 'package:projectunity/bloc/network/network_connection_state.dart';
import 'package:projectunity/l10n/l10n.dart';
import 'package:projectunity/navigation/app_back_button_dispatcher.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'configs/theme.dart';
import 'di/service_locator.dart';
import 'navigation/main_router_delegate.dart';
import 'navigation/navigation_stack_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies();
  runApp(
    BlocProvider(
      create:(_)=>NetworkConnectionBloc(Connectivity())..add(NetworkConnectionObserveEvent()),
        child: const MyApp()),
  );
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    String error = flutterErrorDetails.exceptionAsString();
    return ErrorScreen(error: error);
  };
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _stateManager = getIt<NavigationStackManager>();
  final _userManager = getIt<UserManager>();
  late MainRouterDelegate _routerDelegate;
  late AppBackButtonDispatcher _backButtonDispatcher;

  _MyAppState() {
    _backButtonDispatcher = AppBackButtonDispatcher(_stateManager);
    _routerDelegate =
        MainRouterDelegate(stack: _stateManager, userManager: _userManager);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: L10n.all,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home:BlocListener<NetworkConnectionBloc,NetworkConnectionState>(
        listener: (context,state){
          if(state is NetworkConnectionFailureState){
            String connectionFailedMessage= AppLocalizations.of(context).check_your_connection_error;
            showSnackBar(context: context,msg: connectionFailedMessage);
          }
        },
        child: Router(backButtonDispatcher: _backButtonDispatcher,
                  routerDelegate: _routerDelegate),
      )
    );
  }
}
