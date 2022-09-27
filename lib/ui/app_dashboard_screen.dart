import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projectunity/navigation/main_router_delegate.dart';
import 'package:projectunity/navigation/router_info_parser.dart';

import '../configs/theme.dart';
import '../di/service_locator.dart';
import '../l10n/l10n.dart';
import '../navigation/navigation_stack_manager.dart';
class AppDashboardScreen extends StatefulWidget {

  const AppDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AppDashboardScreen> createState() => _AppDashboardScreenState();
}

class _AppDashboardScreenState extends State<AppDashboardScreen> {
  final _stateManager = getIt<NavigationStackManager>();

  @override
  void initState() {
    super.initState();
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
      home: Router(
          routeInformationParser: HomeRouterInfoParser(),
          routerDelegate: MainRouterDelegate(stack: _stateManager)),
    );
  }
}
