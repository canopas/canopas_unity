import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/const/leave_status.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/stateManager/admin/leave_status_manager.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/reason_dialogue.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';

class ButtonContent extends StatelessWidget {
  final _leaveStatusManager = getIt<LeaveStatusManager>();
  final _stackManager = getIt<NavigationStackManager>();
  final String leaveId;

  ButtonContent({Key? key, required this.leaveId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              _leaveStatusManager.updateStatus(rejectLeaveStatus);
              if (_leaveStatusManager.reason == null) {
                showDialog(
                    context: context,
                    builder: (_) {
                      return ReasonDialogue();
                    });
              }

              _leaveStatusManager.addLeaveApproval(leaveId)
                  ? _stackManager.pop()
                  : null;
            },
            child: const Text(
              'REJECT',
              style: TextStyle(
                  color: AppColors.darkText, fontSize: subTitleTextSize),
            )),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
            onPressed: () {
              _leaveStatusManager.updateStatus(approveLeaveStatus);
              _leaveStatusManager.addLeaveApproval(leaveId)
                  ? _stackManager.pop()
                  : null;
            },
            style: ElevatedButton.styleFrom(primary: AppColors.primaryBlue),
            child: const Text(
              'APPROVE',
              style: TextStyle(fontSize: subTitleTextSize),
            ))
      ],
    );
  }
}
