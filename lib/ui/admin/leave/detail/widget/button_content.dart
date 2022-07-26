import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/const/leave_status.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/stateManager/admin/leave_status_update.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/reason_dialogue.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';

class ButtonContent extends StatelessWidget {
  final _updateLeaveStatus = getIt<UpdateLeaveStatus>();

  ButtonContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              _updateLeaveStatus.updateStatus(rejectLeaveStatus);
              showDialog(
                  context: context,
                  builder: (_) {
                    return ReasonDialogue();
                  });
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
              _updateLeaveStatus.updateStatus(approveLeaveStatus);
              //Pass leaveId instead of empty string
              _updateLeaveStatus.addLeaveApproval('');
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
