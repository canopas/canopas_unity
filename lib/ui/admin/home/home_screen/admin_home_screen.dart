import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/ui/admin/home/home_screen/widget/request_list.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_bloc.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_event.dart';
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_event.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/provider/user_state.dart';
import '../../../../style/app_text_style.dart';
import '../../../shared/appbar_drawer/appbar/space_notifier_widget.dart';
import '../../../shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart';
import '../../../shared/appbar_drawer/drawer/bloc/app_drawer_event.dart';
import '../../../shared/events/celebrations_event_card.dart';
import '../../../shared/who_is_out_card/bloc/who_is_out_card_bloc.dart';
import '../../../shared/who_is_out_card/who_is_out_card.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/empty_screen.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/admin_home_bloc.dart';
import 'bloc/admin_home_event.dart';
import 'bloc/admin_home_state.dart';

class AdminHomeScreenPage extends StatelessWidget {
  const AdminHomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt.get<AdminHomeBloc>()..add(AdminHomeInitialLoadEvent()),
        ),
        BlocProvider(
            create: (context) =>
                getIt<WhoIsOutCardBloc>()..add(FetchWhoIsOutCardLeaves())),
        BlocProvider(
            create: (context) =>
                getIt<CelebrationsBloc>()..add(FetchCelebrations())),
      ],
      child: const AdminHomeScreen(),
    );
  }
}

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return AppPage(
      backGroundColor: context.colorScheme.surface,
      leading: InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
            context.read<DrawerBloc>().add(FetchSpacesEvent());
          },
          child: Icon(
            Icons.menu,
            color: context.colorScheme.textPrimary,
          )),
      titleWidget: SpaceNotifierWidget(
        notifier: getIt.get<UserStateNotifier>(),
        child: Builder(
          builder: (context) {
            final String name = SpaceNotifierWidget.of(context)?.name ?? "";
            return Text(name,
                style: AppTextStyle.headerStyle(context),
                overflow: TextOverflow.ellipsis);
          },
        ),
      ),
      body: ListView(
        children: [
          const WhoIsOutCard(),
          const EventCard(),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<AdminHomeBloc, AdminHomeState>(
              listenWhen: (previous, current) => current.status == Status.error,
              listener: (context, state) {
                if (state.status == Status.error) {
                  showSnackBar(context: context, error: state.error);
                }
              },
              buildWhen: (previous, current) => current.status != Status.error,
              builder: (context, state) {
                if (state.status == Status.success &&
                    state.leaveAppMap.isNotEmpty) {
                  return LeaveRequestList(map: state.leaveAppMap);
                }
                return state.status == Status.loading
                    ? const AppCircularProgressIndicator()
                    : EmptyScreen(
                        message: locale.empty_request_message,
                        title: locale.empty_request_title,
                      );
              }),
        ],
      ),
    );
  }
}
