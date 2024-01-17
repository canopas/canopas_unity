import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/empty_screen.dart';
import '../../../../data/di/service_locator.dart';
import '../../../navigation/app_router.dart';
import '../../../shared/appbar_drawer/appbar/dashboard_appbar.dart';
import '../../../shared/who_is_out_card/bloc/who_is_out_card_bloc.dart';
import '../../../shared/who_is_out_card/who_is_out_card.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_card.dart';
import 'bloc/user_home_bloc.dart';

class UserHomeScreenPage extends StatelessWidget {
  const UserHomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<UserHomeBloc>()..add(UserHomeFetchLeaveRequest()),
        ),
        BlocProvider(
            create: (_) =>
                getIt<WhoIsOutCardBloc>()..add(FetchWhoIsOutCardLeaves())),
      ],
      child: const UserHomeScreen(),
    );
  }
}

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
        appBar: DashBoardAppBar(onTap: () => Scaffold.of(context).openDrawer()),
        body: ListView(
          padding: const EdgeInsets.all(primaryHorizontalSpacing),
          children: [
            const WhoIsOutCard(),
            BlocConsumer<UserHomeBloc, UserHomeState>(
                buildWhen: (previous, current) =>
                    current is! UserHomeErrorState,
                builder: (context, state) {
                  if (state is UserHomeSuccessState &&
                      state.requests.isNotEmpty) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25, bottom: 10),
                            child: Text(locale.request_tag,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall),
                          ),
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, leave) => LeaveCard(
                                  onTap: () {
                                    context.goNamed(
                                        Routes.userRequestDetail,
                                        pathParameters: {
                                          RoutesParamsConst.leaveId:
                                              state.requests[leave].leaveId
                                        });
                                  },
                                  leave: state.requests[leave]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemCount: state.requests.length),
                        ]);
                  }
                  return ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 300,
                      ),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height - 500,
                          child: state is UserHomeLoadingState ||
                                  state is UserHomeInitialState
                              ? const AppCircularProgressIndicator()
                              : EmptyScreen(
                                  title: locale.empty_request_title,
                                  message: locale.empty_request_message)));
                },
                listenWhen: (previous, current) =>
                    current is UserHomeErrorState,
                listener: (context, state) {
                  if (state is UserHomeErrorState) {
                    showSnackBar(context: context, error: state.error);
                  }
                })
          ],
        ));
  }
}
