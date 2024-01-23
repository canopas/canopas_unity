import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/ui/style/app_theme.dart';
import 'package:projectunity/ui/style/colors.dart';
import 'package:projectunity/ui/widget/error/error_screen.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'data/bloc/user_state/user_state_controller_bloc.dart';
import 'data/core/utils/const/app_const.dart';
import 'data/configs/scroll_behavior.dart';
import 'data/configs/theme.dart';
import 'data/bloc/network/network_connection_bloc.dart';
import 'data/bloc/network/network_connection_event.dart';
import 'data/bloc/network/network_connection_state.dart';
import 'data/di/service_locator.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'firebase_options.dart';
import 'ui/navigation/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    getIt<FirebaseCrashlytics>().recordFlutterFatalError(flutterErrorDetails);
    String error = flutterErrorDetails.exceptionAsString();
    return ErrorScreen(error: error);
  };

  if (kDebugMode && !kIsWeb) {
    await getIt<FirebaseCrashlytics>().setCrashlyticsCollectionEnabled(false);
  }

  PlatformDispatcher.instance.onError = (error, stack) {
    getIt<FirebaseCrashlytics>().recordError(error, stack, fatal: true);
    return true;
  };

  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final GoRouter _router = getIt<AppRouter>().router;
  final _networkConnectionBloc = getIt<NetworkConnectionBloc>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    final colorScheme = isDarkMode ? appColorSchemeDark : appColorSchemeLight;
    return AppThemeWidget(
      colorScheme: colorScheme,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  _networkConnectionBloc..add(NetworkConnectionObserveEvent())),
          BlocProvider(create: (context) => getIt<UserStateControllerBloc>()),
        ],
        child: GestureDetector(
          onTap: () {
            if (!FocusScope.of(context).hasPrimaryFocus &&
                FocusScope.of(context).focusedChild != null) {
              FocusScope.of(context).focusedChild?.unfocus();
            }
          },
          child: Platform.isIOS
              ? CupertinoApp.router(
                  title: AppConsts.appTitle,
                  scrollBehavior: AppScrollBehaviour(),
                  debugShowCheckedModeBanner: false,
                  theme:CupertinoThemeData(
                    brightness: context.brightness,
                    primaryColor: colorScheme.primary,
                    applyThemeToAll: true,
                  ),
                  routerConfig: _router,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  builder: (context, widget) => BlocListener<
                          NetworkConnectionBloc, NetworkConnectionState>(
                        listenWhen: (previous, current) =>
                            current is NetworkConnectionFailureState,
                        listener: (context, state) {
                          if (state is NetworkConnectionFailureState) {
                            String connectionErrorMessage =
                                AppLocalizations.of(context)
                                    .network_connection_error;
                            showSnackBar(
                                context: context, msg: connectionErrorMessage);
                          }
                        },
                        child: widget,
                      ))
              : MaterialApp.router(
                  title: AppConsts.appTitle,
                  scrollBehavior: AppScrollBehaviour(),
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.theme,
                  routerConfig: _router,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  builder: (context, widget) => BlocListener<
                          NetworkConnectionBloc, NetworkConnectionState>(
                        listenWhen: (previous, current) =>
                            current is NetworkConnectionFailureState,
                        listener: (context, state) {
                          if (state is NetworkConnectionFailureState) {
                            String connectionErrorMessage =
                                AppLocalizations.of(context)
                                    .network_connection_error;
                            showSnackBar(
                                context: context, msg: connectionErrorMessage);
                          }
                        },
                        child: widget,
                      )),
        ),
      ),
    );
  }
}
