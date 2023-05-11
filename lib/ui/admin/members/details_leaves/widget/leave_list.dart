import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/empty_screen.dart';
import '../../../../widget/leave_card.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class EmployeeLeaveList extends StatelessWidget {
  final bool isLoading;
  final List<Leave> leaves;
  final String employeeName;

  const EmployeeLeaveList(
      {Key? key,
        required this.isLoading,
        required this.leaves,
        required this.employeeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const AppCircularProgressIndicator()
        : leaves.isEmpty
        ? EmptyScreen(
        message: AppLocalizations.of(context)
            .employee_empty_leave_message(employeeName),
        title: AppLocalizations.of(context).no_leaves_tag)
        : ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: leaves.length,
      itemBuilder: (context, index) => LeaveCard(
        onTap: () {
          context.goNamed(Routes.adminEmployeeDetailsLeavesDetails,
              params: {
                RoutesParamsConst.employeeId: leaves[index].uid,
                RoutesParamsConst.leaveId: leaves[index].leaveId,
                RoutesParamsConst.employeeName: employeeName,
              });
        },
        leave: leaves[index],
      ),
      separatorBuilder: (BuildContext context, int index) =>
      const SizedBox(height: 16),
    );
  }
}
