import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:projectunity/data/l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_theme.dart';
import 'package:projectunity/style/colors.dart';
import 'package:projectunity/ui/app.dart';
import 'package:projectunity/ui/widget/error/error_screen.dart';
import 'data/core/utils/const/app_const.dart';
import 'data/configs/scroll_behavior.dart';
import 'data/di/service_locator.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'firebase_options.dart';
import 'app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    getIt<FirebaseCrashlytics>().recordFlutterFatalError(flutterErrorDetails);
    String error = flutterErrorDetails.exceptionAsString();
    return ErrorScreen(error: error);
  };

  if (!kIsWeb) {
    if (kDebugMode) {
      await getIt<FirebaseCrashlytics>().setCrashlyticsCollectionEnabled(false);
    } else {
      await getIt<FirebaseCrashlytics>().setCrashlyticsCollectionEnabled(true);
    }
  }

  PlatformDispatcher.instance.onError = (error, stack) {
    getIt<FirebaseCrashlytics>().recordError(error, stack, fatal: true);
    return true;
  };

  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = getIt<AppRouter>().router();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    final colorScheme = isDarkMode ? appColorSchemeDark : appColorSchemeLight;
    return AppThemeWidget(
      colorScheme: colorScheme,
      child: GestureDetector(
          onTap: () {
            if (!FocusScope.of(context).hasPrimaryFocus &&
                FocusScope.of(context).focusedChild != null) {
              FocusScope.of(context).focusedChild?.unfocus();
            }
          },
          child: kIsWeb || !Platform.isIOS
              ? MaterialApp.router(
                  title: AppConsts.appTitle,
                  scrollBehavior: AppScrollBehaviour(),
                  debugShowCheckedModeBanner: false,
                  theme: materialThemeDataLight,
                  darkTheme: materialThemeDataDark,
                  routerConfig: _router,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  builder: (context, widget) => App(child: widget!))
              : CupertinoApp.router(
                  title: AppConsts.appTitle,
                  scrollBehavior: AppScrollBehaviour(),
                  debugShowCheckedModeBanner: false,
                  theme: CupertinoThemeData(
                    scaffoldBackgroundColor: colorScheme.surface,
                    primaryContrastingColor: colorScheme.onPrimary,
                    brightness: context.brightness,
                    barBackgroundColor: colorScheme.surface,
                    primaryColor: colorScheme.primary,
                    applyThemeToAll: true,
                  ),
                  routerConfig: _router,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  builder: (context, widget) => App(child: widget!))),
    );
  }
}
