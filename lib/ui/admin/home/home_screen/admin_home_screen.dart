import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/ui/admin/home/home_screen/widget/request_list.dart';
import '../../../../data/bloc/user_state/user_controller_state.dart';
import '../../../../data/bloc/user_state/user_state_controller_bloc.dart';
import '../../../../data/bloc/user_state/user_state_controller_event.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/provider/user_state.dart';
import '../../../shared/appbar_drawer/appbar/dashboard_appbar.dart';
import '../../../shared/who_is_out_card/bloc/who_is_out_card_bloc.dart';
import '../../../shared/who_is_out_card/who_is_out_card.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/empty_screen.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/admin_home_bloc.dart';
import 'bloc/admin_home_event.dart';
import 'bloc/admin_home_state.dart';

class AdminHomeScreenPage extends StatelessWidget {
  const AdminHomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          getIt<UserStateControllerBloc>()
            ..add(CheckUserStatus()),
        ),
        BlocProvider(
          create: (context) => getIt.get<AdminHomeBloc>()..add(AdminHomeInitialLoadEvent()),
        ),
        BlocProvider(create: (context) => getIt<WhoIsOutCardBloc>()),
      ],
      child: const AdminHomeScreen(),
    );

  }
}

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: DashBoardAppBar(onTap: () => Scaffold.of(context).openDrawer()),
      body: BlocListener<UserStateControllerBloc, UserControllerState>(
        listenWhen: (previous, current) => previous.userState != current.userState,
        listener: (context, state) {
          if (state.userState == UserState.unauthenticated) {
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
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: primaryHorizontalSpacing,
                  vertical: primaryHalfSpacing),
              child: WhoIsOutCard(),
            ),
            BlocConsumer<AdminHomeBloc, AdminHomeState>(
                listenWhen: (previous, current) =>
                current.status == Status.error,
                listener: (context, state) {
                  if (state.status == Status.error) {
                    showSnackBar(context: context, error: state.error);
                  }
                },
                buildWhen: (previous, current) =>
                current.status != Status.error,
                builder: (context, state) {
                  if (state.status == Status.success &&
                      state.leaveAppMap.isNotEmpty) {
                    return LeaveRequestList(map: state.leaveAppMap);
                  }
                  return ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 300),
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 500,
                      child: state.status == Status.loading
                          ? const AppCircularProgressIndicator()
                          : EmptyScreen(
                        message: locale.empty_request_message,
                        title: locale.empty_request_title,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
