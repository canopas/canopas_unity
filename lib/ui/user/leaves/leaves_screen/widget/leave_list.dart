import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/widget/empty_screen.dart';
import 'package:projectunity/ui/widget/pagination_widget.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../app_router.dart';
import '../bloc/leaves/user_leave_bloc.dart';

class LeaveList extends StatefulWidget {
  final Map<DateTime, List<Leave>> leaves;
  final LeaveType leaveType;
  final Status status;

  const LeaveList(
      {super.key,
      required this.leaves,
      required this.leaveType,
      required this.status});

  @override
  State<LeaveList> createState() => _LeaveListState();
}

class _LeaveListState extends State<LeaveList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _scrollListener();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(() {});
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<UserLeaveBloc>().add(FetchMoreUserLeaves(widget.leaveType));
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> navigateToLeaveDetails(Leave leave) async {
      final bloc = context.read<UserLeaveBloc>();
      final String? leaveId = await context.pushNamed(Routes.userLeaveDetail,
          pathParameters: {RoutesParamsConst.leaveId: leave.leaveId});
      if (leaveId != null) {
        bloc.add(UpdateLeave(leaveId: leaveId));
      }
    }

    return widget.leaves.isNotEmpty
        ? ListView(
            controller: _scrollController,
            children: widget.leaves.entries
                .map((MapEntry<DateTime, List<Leave>> monthWiseLeaves) =>
                    StickyHeader(
                        header: LeaveListHeader(
                          title: context.l10n
                              .date_format_yMMMM(monthWiseLeaves.key),
                          count: monthWiseLeaves.value.length,
                        ),
                        content: LeaveListByMonth(
                          onCardTap: navigateToLeaveDetails,
                          isPaginationLoading:
                              monthWiseLeaves.key == widget.leaves.keys.last &&
                                  widget.status == Status.loading,
                          leaves: monthWiseLeaves.value,
                        )))
                .toList(),
          )
        : EmptyScreen(
            title: context.l10n.no_leaves_tag,
            message: context.l10n.user_leave_empty_screen_message);
  }
}
