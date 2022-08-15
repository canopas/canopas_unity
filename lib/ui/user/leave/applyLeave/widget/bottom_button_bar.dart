import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/colors.dart';
import '../../../../../core/utils/const/other_constant.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../navigation/navigationStackItem/employee/employee_navigation_stack_item.dart';
import '../../../../../navigation/navigation_stack_manager.dart';
import '../../../../../provider/user_data.dart';
import '../../../../../stateManager/user/leave_request_data_manager.dart';
import '../leave_request_form.dart';

class BottomButtonBar extends StatelessWidget {
  final _stateManager = getIt<NavigationStackManager>();
  final _userManager = getIt<UserManager>();
  final service = getIt<UserLeaveService>();

  BottomButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);

    final _leaveService =
        Provider.of<LeaveRequestDataManager>(context, listen: false);
    return Container(
      padding:  const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  _localization.user_apply_leave_button_reset,
                  style: const TextStyle(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  _localization.user_apply_leave_button_apply_leave,
                  style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: titleTextSize,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  String _userId = _userManager.employeeId;
                  Leave data =
                  _leaveService.getLeaveRequestData(userId: _userId);
                  service.applyForLeave(data);
                  _stateManager.clearAndPush(
                      const EmployeeNavigationStackItem.employeeHomeState());
                  _stateManager.setBottomBar(true);
                } else {
                  showSnackBar(
                      context,
                      _localization
                          .user_apply_leave_error_message_fill_details);
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
