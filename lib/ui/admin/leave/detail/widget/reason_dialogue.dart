import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../../../stateManager/admin/leave_status_manager.dart';

class ReasonDialogue extends StatelessWidget {
  final _updateLeaveStatus = getIt<LeaveStatusManager>();

  ReasonDialogue({
    Key? key,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return AlertDialog(
      content: SizedBox(
        width: 300,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: (_localization.admin_leave_detail_error_reason),
              border: InputBorder.none),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (controller.text == '') {
                showSnackBar(context,
                    _localization.admin_leave_detail_error_reason_rejection);
              } else if (controller.text != '') {
                _updateLeaveStatus.setReason(controller.text);
              }
              Navigator.pop(context);
            },
            child: Text(_localization.admin_leave_detail_button_ok))
      ],
    );
  }
}
