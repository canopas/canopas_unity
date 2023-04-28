import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/empty_screen.dart';
import '../../../../widget/leave_card.dart';

class LeaveList extends StatelessWidget {
  final String employeeName;
  final Status status;
  final List<Leave> leaves;
  final String emptyStringTitle;
  final String emptyStringMessage;

  const LeaveList(
      {Key? key,
      required this.status,
      required this.leaves,
      required this.emptyStringTitle,
      required this.emptyStringMessage,
      required this.employeeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return status == Status.loading
        ? const AppCircularProgressIndicator()
        : leaves.isEmpty
            ? EmptyScreen(message: emptyStringMessage, title: emptyStringTitle)
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: leaves.length,
                itemBuilder: (context, leave) => LeaveCard(
                  onTap: () {
                    context.goNamed(Routes.adminEmployeeDetailsLeavesDetails,
                        params: {
                          RoutesParamsConst.employeeId : leaves[leave].uid,
                RoutesParamsConst.leaveId : leaves[leave].leaveId,
                RoutesParamsConst.employeeName : employeeName,
              });
        },
        leave: leaves[leave],
      ),
      separatorBuilder: (BuildContext context, int index) =>
      const SizedBox(height: 16),
    );
  }
}

