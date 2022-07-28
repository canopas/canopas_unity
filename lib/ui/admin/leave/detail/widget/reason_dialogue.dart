import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/stateManager/admin/leave_status_manager.dart';
import 'package:projectunity/widget/error_snackbar.dart';

class ReasonDialogue extends StatelessWidget {
  final _updateLeaveStatus = getIt<LeaveStatusManager>();

  ReasonDialogue({
    Key? key,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 300,
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
              hintText: ('Please enter reason'), border: InputBorder.none),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (controller.text == '') {
                showSnackBar(context, 'Please provide reason for rejection');
              } else if (controller.text != '') {
                _updateLeaveStatus.setReason(controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ],
    );
  }
}
