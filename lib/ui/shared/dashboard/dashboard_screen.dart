import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/bloc/user_state/space_user_bloc.dart';

import '../../../data/bloc/user_state/space_user_state.dart';
import '../../../data/bloc/user_state/space_user_event.dart';
import '../../../data/di/service_locator.dart';
import '../appbar_drawer/drawer/app_drawer.dart';
import '../appbar_drawer/drawer/bloc/app_drawer_bloc.dart';
import 'navigation_item.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;
  final List<BottomNavigationItem> items;

  const DashboardScreen({Key? key, required this.child, required this.items})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int get _currentIndex => locationToTabIndex(GoRouter.of(context).location);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return BlocProvider(
      create: (_) => getIt<DrawerBloc>(),
      child: Scaffold(
        drawer: const AppDrawer(),
        body: SafeArea(
            child: BlocListener<SpaceUserBloc, SpaceUserState>(
          listenWhen: (previous, current) =>
              current is SpaceUserRevokeAccessState,
          listener: (_, state) {
            if (state is SpaceUserRevokeAccessState) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(locale
                          .state_controller_access_revoked_alert_dialogue_title),
                      content: Text(locale
                          .state_controller_access_revoked_alert_dialogue_subtitle),
                      actions: [
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<SpaceUserBloc>(context)
                                      .add(DeactivateUserEvent());
                                },
                                child: Text(locale.ok_tag))
                          ],
                        );
                      });
                }
              },
              child: widget.child,
        )),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) => onItemTapped(index),
          items: widget.items,
          currentIndex: _currentIndex,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    context.goNamed(widget.items[index].initialLocation);
  }

  int locationToTabIndex(String location) {
    final index = widget.items.indexWhere((bottomNavigationItem) =>
        location.startsWith(bottomNavigationItem.initialLocation));
    return index < 0 ? 0 : index;
  }
}
