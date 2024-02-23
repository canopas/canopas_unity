import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/navigation/app_router.dart';
import 'package:projectunity/ui/shared/dashboard/navigation_item.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/app_drawer.dart';
import 'package:projectunity/ui/style/colors.dart';
import '../../../data/bloc/user_state/user_controller_state.dart';
import '../../../data/bloc/user_state/user_state_controller_bloc.dart';
import '../../../data/bloc/user_state/user_state_controller_event.dart';
import '../../../data/di/service_locator.dart';
import '../../shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class DashBoardScreen extends StatefulWidget {
  final Widget child;
  final List<BottomNavigationItem> tabs;

  const DashBoardScreen({Key? key, required this.child, required this.tabs})
      : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int get _currentIndex => locationToTabIndex(GoRouter.of(context).location());

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => getIt.get<DrawerBloc>(),
      child: Scaffold(
        drawer: const AppDrawer(),
        body: SafeArea(
            child: BlocListener<UserStateControllerBloc, UserControllerStatus>(
                listener: (context, state) {
                  if (state is UserAccessRevokedStatus) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(locale
                                .state_controller_access_revoked_alert_dialogue_title),
                            content: Text(locale
                                .state_controller_access_revoked_alert_dialogue_subtitle),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    context
                                        .read<UserStateControllerBloc>()
                                        .add(ClearDataForDisableUser());
                                  },
                                  child: Text(locale.ok_tag))
                            ],
                          );
                        });
                  }
                },
                child: widget.child)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: surfaceColor,
          selectedItemColor: primaryLightColor,
          unselectedItemColor: textDisabledColor,
          onTap: (int index) => onItemTapped(index),
          items: widget.tabs.map((e) => e.toBottomNavigationItem(context)).toList(),
          currentIndex: _currentIndex,
        ),
      ),
    );
  }


  void onItemTapped(int index) {
    context.goNamed(widget.tabs[index].initialLocation);
  }

  int locationToTabIndex(String location) {
    final index = widget.tabs.indexWhere((bottomNavigationItem) =>
        location.startsWith(bottomNavigationItem.initialLocation));
    return index < 0 ? 0 : index;
  }
}
