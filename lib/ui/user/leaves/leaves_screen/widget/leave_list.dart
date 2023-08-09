import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/widget/empty_screen.dart';
import 'package:projectunity/ui/widget/pagination_widget.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/error_snack_bar.dart';
import '../bloc/leaves/user_leave_bloc.dart';
import '../bloc/leaves/user_leave_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LeaveList extends StatelessWidget {
  const LeaveList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<void> navigateToLeaveDetails(Leave leave) async {
      final bloc = context.read<UserLeaveBloc>();
      final String? leaveId = await context.pushNamed(Routes.userLeaveDetail,
          params: {RoutesParamsConst.leaveId: leave.leaveId});
      if (leaveId != null) {
        bloc.add(UpdateLeave(leaveId: leaveId));
      }
    }

    return BlocConsumer<UserLeaveBloc, UserLeaveState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.leavesMap != current.leavesMap ||
          previous.fetchMoreDataStatus != current.fetchMoreDataStatus,
      builder: (context, state) {
        if (state.status == Status.success && state.leavesMap.isNotEmpty) {
          return Column(
            children: state.leavesMap.entries
                .map((MapEntry<DateTime, List<Leave>> monthWiseLeaves) =>
                    StickyHeader(
                        header: LeaveListHeader(
                          title: AppLocalizations.of(context)
                              .date_format_yMMMM(monthWiseLeaves.key),
                          count: monthWiseLeaves.value.length,
                        ),
                        content: LeaveListByMonth(
                          onCardTap: navigateToLeaveDetails,
                          isPaginationLoading: monthWiseLeaves.key ==
                                  state.leavesMap.keys.last &&
                              state.fetchMoreDataStatus == Status.loading,
                          leaves: monthWiseLeaves.value,
                        )))
                .toList(),
          );
        }
        return ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 300,
            ),
            child: SizedBox(
                height: MediaQuery.of(context).size.height - 500,
                child: state.status == Status.loading
                    ? const AppCircularProgressIndicator()
                    : EmptyScreen(
                        title: AppLocalizations.of(context).no_leaves_tag,
                        message: AppLocalizations.of(context)
                            .user_leave_empty_screen_message)));
      },
      listenWhen: (previous, current) =>
          current.status == Status.error ||
          current.fetchMoreDataStatus == Status.error,
      listener: (context, state) {
        if (state.error != null) {
          showSnackBar(context: context, error: state.error);
        }
      },
    );
  }
}
