import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/leave_detail_content.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/leave_title_row.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/leaves_left_content.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/user_content.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../configs/colors.dart';
import '../../../../core/utils/const/other_constant.dart';
import 'widget/button_content.dart';

class AdminLeaveRequestDetailScreen extends StatelessWidget {
  LeaveApplication employeeLeave;
  final _stateManger = getIt<NavigationStackManager>();

  AdminLeaveRequestDetailScreen({Key? key, required this.employeeLeave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).leave_detail_title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: primaryHorizontalSpacing,
            right: primaryHorizontalSpacing,
            bottom: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  UserContent(employee: employeeLeave.employee),
                  const LeavesLeftContent(),
                  const Divider(color: AppColors.secondaryText),
                  LeaveTitleRow(
                    leave: employeeLeave.leave,
                  ),
                  LeaveDetailContent(leave: employeeLeave.leave),
                ],
              ),
            ),
            ButtonContent(
              leaveId: employeeLeave.leave.leaveId,
            ),
          ],
        ),
      ),
    );
  }
}
