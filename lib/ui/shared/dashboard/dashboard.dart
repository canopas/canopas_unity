import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/app_router.dart';
import 'package:projectunity/ui/shared/dashboard/navigation_item.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/app_drawer.dart';
import 'package:projectunity/ui/widget/app_dialog.dart';
import 'package:projectunity/data/bloc/user_state/user_controller_state.dart';
import 'package:projectunity/data/bloc/user_state/user_state_controller_bloc.dart';
import 'package:projectunity/data/bloc/user_state/user_state_controller_event.dart';
import 'package:projectunity/data/l10n/app_localization.dart';

class DashBoardScreen extends StatefulWidget {
  final Widget child;
  final List<BottomNavigationItem> tabs;

  const DashBoardScreen({super.key, required this.child, required this.tabs});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int get _currentIndex => locationToTabIndex(GoRouter.of(context).location());

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: BlocListener<UserStateControllerBloc, UserControllerStatus>(
          listenWhen: (previous, current) => current is UserAccessRevokedStatus,
          listener: (context, state) {
            if (state is UserAccessRevokedStatus) {
              showAppAlertDialog(
                context: context,
                title:
                    locale.state_controller_access_revoked_alert_dialogue_title,
                actionButtonTitle: locale.ok_tag,
                description: locale
                    .state_controller_access_revoked_alert_dialogue_subtitle,
                onActionButtonPressed: () => context
                    .read<UserStateControllerBloc>()
                    .add(ClearDataForDisableUser()),
              );
            }
          },
          child: widget.child,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.colorScheme.surface,
        selectedItemColor: context.colorScheme.primary,
        unselectedItemColor: context.colorScheme.textPrimary,
        onTap: (int index) => onItemTapped(index),
        items: widget.tabs
            .map((e) => e.toBottomNavigationItem(context))
            .toList(),
        currentIndex: _currentIndex,
      ),
    );
  }

  void onItemTapped(int index) {
    context.goNamed(widget.tabs[index].initialLocation);
  }

  int locationToTabIndex(String location) {
    final index = widget.tabs.indexWhere(
      (bottomNavigationItem) =>
          location.startsWith(bottomNavigationItem.initialLocation),
    );
    return index < 0 ? 0 : index;
  }
}
