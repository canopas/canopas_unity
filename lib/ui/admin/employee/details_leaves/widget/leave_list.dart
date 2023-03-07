import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/leave_card.dart';
import 'package:flutter/material.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../router/app_router.dart';
import '../../../../../widget/circular_progress_indicator.dart';
import '../../../../../widget/empty_screen.dart';

class LeaveList extends StatelessWidget {
  final bool isLoading;
  final List<Leave> leaves;
  final Employee employee;
  final String emptyStringTitle;
  final String emptyStringMessage;

  const LeaveList(
      {Key? key,
        required this.isLoading,
        required this.leaves,
        required this.employee,
        required this.emptyStringTitle,
        required this.emptyStringMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const AppCircularProgressIndicator()
        : leaves.isEmpty
        ? EmptyScreen(message: emptyStringMessage, title: emptyStringTitle)
        : ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: leaves.length,
      itemBuilder: (context, leave) => UserLeaveCard(
            onTap: () {
              context.goNamed(Routes.adminEmployeeDetailsLeavesDetails,
              extra: employee,
              params: {
                RoutesParamsConst.employeeId : leaves[leave].uid,
                RoutesParamsConst.leaveId : leaves[leave].leaveId,
              });
        },
        leave: leaves[leave],
      ),
      separatorBuilder: (BuildContext context, int index) =>
      const SizedBox(height: 16),
    );
  }
}
