import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_events.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/empty_screen.dart';
import '../../../../widget/error_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../widget/pagination_widget.dart';
import '../bloc/admin_employee_details_leave_bloc.dart';
import '../bloc/admin_employee_details_leave_state.dart';

class EmployeeLeaveList extends StatefulWidget {
  final String employeeName;

  const EmployeeLeaveList({Key? key, required this.employeeName})
      : super(key: key);

  @override
  State<EmployeeLeaveList> createState() => _EmployeeLeaveListState();
}

class _EmployeeLeaveListState extends State<EmployeeLeaveList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<AdminEmployeeDetailsLeavesBLoc>().add(FetchMoreUserLeaves());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminEmployeeDetailsLeavesBLoc,
            AdminEmployeeDetailsLeavesState>(
        listenWhen: (previous, current) =>
            current.status == Status.error ||
            current.fetchMoreDataStatus == Status.error,
        listener: (context, state) {
          if (state.error == null) {
            showSnackBar(context: context, error: state.error);
          }
        },
        buildWhen: (previous, current) =>
            previous.leavesMap != current.leavesMap ||
            previous.status != current.status ||
            previous.fetchMoreDataStatus != current.fetchMoreDataStatus,
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const AppCircularProgressIndicator();
          } else if (state.leavesMap.isEmpty) {
            return EmptyScreen(
                message: AppLocalizations.of(context)
                    .employee_empty_leave_message(widget.employeeName),
                title: AppLocalizations.of(context).no_leaves_tag);
          }
          return ListView(
            controller: _scrollController,
            children: state.leavesMap.entries
                .map((MapEntry<DateTime, List<Leave>> monthWiseLeaves) =>
                    StickyHeader(
                        header: LeaveListHeader(
                          title: AppLocalizations.of(context)
                              .date_format_yMMMM(monthWiseLeaves.key),
                          count: monthWiseLeaves.value.length,
                        ),
                        content: LeaveListByMonth(
                          onCardTap: (leave) {
                            context.goNamed(
                                Routes.adminEmployeeDetailsLeavesDetails,
                                params: {
                                  RoutesParamsConst.employeeId: leave.uid,
                                  RoutesParamsConst.leaveId: leave.leaveId,
                                  RoutesParamsConst.employeeName:
                                      widget.employeeName,
                                });
                          },
                          isPaginationLoading: monthWiseLeaves.key ==
                                  state.leavesMap.keys.last &&
                              state.fetchMoreDataStatus == Status.loading,
                          leaves: monthWiseLeaves.value,
                        )))
                .toList(),
          );
        });
  }
}
