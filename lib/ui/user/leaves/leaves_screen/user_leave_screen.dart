import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/double_extension.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/colors.dart';
import 'package:projectunity/ui/navigation/app_router.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_state.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/leave_count_card.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/leave_list.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/leave/leave.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/empty_screen.dart';
import 'bloc/leave_count/user_leave_count_bloc.dart';
import 'bloc/leave_count/user_leave_cout_event.dart';
import 'bloc/leaves/user_leave_bloc.dart';
import 'bloc/leaves/user_leave_event.dart';
import 'bloc/leaves/user_leave_state.dart';

class UserLeavePage extends StatelessWidget {
  const UserLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) =>
              getIt<UserLeaveCountBloc>()..add(FetchLeaveCountEvent())),
      BlocProvider(
          create: (_) => getIt<UserLeaveBloc>()..add(LoadInitialUserLeaves()))
    ], child: const UserLeaveScreen());
  }
}

class UserLeaveScreen extends StatefulWidget {
  const UserLeaveScreen({Key? key}) : super(key: key);

  @override
  State<UserLeaveScreen> createState() => _UserLeaveScreenState();
}

class _UserLeaveScreenState extends State<UserLeaveScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  double casualLeaves = 0.0;
  double urgentLeaves = 0.0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void navigateToApplyLeave() async {
      final bloc = context.read<UserLeaveBloc>();
      final String? leaveId = await context.pushNamed(Routes.applyLeave);
      if (leaveId != null) {
        bloc.add(UpdateLeave(leaveId: leaveId));
      }
    }

    return AppPage(
      title: AppLocalizations.of(context).leaves_tag,
      body: Column(
        children: [
          BlocBuilder<UserLeaveCountBloc, UserLeaveCountState>(
              builder: (context, state) {
            if (state.status == Status.success) {
              casualLeaves = state.usedLeavesCounts.casualLeaves;
              urgentLeaves = state.usedLeavesCounts.urgentLeaves;
            }
            return TabBar(
              padding: const EdgeInsets.only(bottom: 16),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: AppTextStyle.style16,
              labelPadding: const EdgeInsets.all(10),
              controller: _tabController,
              tabs: [
                Text(
                    "${context.l10n.leave_type_placeholder_text(LeaveType.casualLeave.value.toString())}(${casualLeaves})"),
                Text(
                  "${context.l10n.leave_type_placeholder_text(LeaveType.urgentLeave.value.toString())}(${urgentLeaves})",
                ),
              ],
            );
          }),
          BlocBuilder<UserLeaveBloc, UserLeaveState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == Status.success) {
                  return Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      LeaveList(
                        leaves: state.casualLeaves,
                        status: state.fetchMoreDataStatus,
                        leaveType: LeaveType.casualLeave,
                      ),
                      LeaveList(
                        leaves: state.urgentLeaves,
                        status: state.fetchMoreDataStatus,
                        leaveType: LeaveType.urgentLeave,
                      ),
                    ]),
                  );
                }
                return Expanded(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 300,
                      ),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height - 500,
                          child: state.status == Status.loading
                              ? const AppCircularProgressIndicator()
                              : EmptyScreen(
                                  title: AppLocalizations.of(context)
                                      .no_leaves_tag,
                                  message: AppLocalizations.of(context)
                                      .user_leave_empty_screen_message))),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToApplyLeave,
        child: const Icon(Icons.add),
      ),
    );
  }
}
