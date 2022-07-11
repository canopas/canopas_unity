import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/colors.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../navigation/navigation_stack_item.dart';
import '../../../../../navigation/navigation_stack_manager.dart';
import '../../../../../stateManager/apply_leave_state_provider.dart';
import '../../../leave/request/leave_request_form.dart';

class BottomButtonBar extends StatelessWidget {
  final _stateManager = getIt<NavigationStackManager>();
  final service = getIt<UserLeaveService>();

  BottomButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _leaveService =
        Provider.of<ApplyLeaveStateProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppColors.boxShadowColor,
          blurRadius: 10,
          spreadRadius: 10,
        ),
      ]),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: titleTextSize,
                  ),
                ),
              ),
              onPressed: () {
                formKey.currentState?.reset();
                _leaveService.resetForm();
              },
              style: ElevatedButton.styleFrom(primary: AppColors.secondaryText),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Apply Leave',
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: titleTextSize,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  LeaveRequestData data = _leaveService.getLeaveRequestData();
                  service.applyForLeave(data);
                  _stateManager.clearAndPush(
                      const NavigationStackItem.employeeHomeState());
                  _stateManager.setBottomBar(true);
                } else {
                  buildSnackBar(context, 'Please fill all details');
                }
              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
