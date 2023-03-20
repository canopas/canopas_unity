import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/firebase_options.dart';
import 'package:projectunity/l10n/l10n.dart';
import 'package:projectunity/ui/widget/empty_screen.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'data/configs/theme.dart';
import 'data/bloc/network/network_connection_bloc.dart';
import 'data/bloc/network/network_connection_event.dart';
import 'data/bloc/network/network_connection_state.dart';
import 'data/di/service_locator.dart';
import 'ui/navigation/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  runApp(MyApp());
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    String error = flutterErrorDetails.exceptionAsString();
    return ErrorScreen(error: error);
  };
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final GoRouter _router = getIt<AppRouter>().router;
  final _networkConnectionBloc = getIt<NetworkConnectionBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          _networkConnectionBloc..add(NetworkConnectionObserveEvent()),
      child: BlocListener<NetworkConnectionBloc, NetworkConnectionState>(
          listenWhen: (previous, current) =>
              current is NetworkConnectionFailureState,
          listener: (context, state) {
            if (state is NetworkConnectionFailureState) {
              String connectionErrorMessage =
                  AppLocalizations.of(context).network_connection_error;
              showSnackBar(context: context, msg: connectionErrorMessage);
            }
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            supportedLocales: L10n.all,
            theme: AppTheme.theme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            routeInformationProvider: _router.routeInformationProvider,
          )),
    );
  }
}
