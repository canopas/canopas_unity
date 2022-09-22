import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/bloc/admin/leave/leave_application_bloc.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/stateManager/admin/leave_status_manager.dart';
import '../../../../../configs/colors.dart';

class ButtonContent extends StatelessWidget {
  final _leaveStatusManager = getIt<LeaveStatusManager>();
  final _stackManager = getIt<NavigationStackManager>();
  final _leaveApplicationBloc = getIt<LeaveApplicationBloc>();
  final String leaveId;
  final String reason;

  ButtonContent({Key? key, required this.leaveId, required this.reason}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width*0.3, 45),
              backgroundColor: AppColors.redColor,
            ),
            onPressed: () {
              _leaveStatusManager.updateStatus(rejectLeaveStatus);
              _leaveStatusManager.setReason(reason);
              if (_leaveStatusManager.leaveApprove(leaveId)) {
                _leaveApplicationBloc.deleteLeaveApplication(leaveId);
                _stackManager.pop();
              }
            },
            child:  Text(_localization.admin_leave_detail_button_reject, style: AppTextStyle.subtitleText,),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width*0.3, 45),
              backgroundColor: AppColors.greenColor,
            ),
            onPressed: () {
              _leaveStatusManager.updateStatus(approveLeaveStatus);
              _leaveStatusManager.setReason(reason);
              if (_leaveStatusManager.leaveApprove(leaveId)) {
                _leaveApplicationBloc.deleteLeaveApplication(leaveId);
                _stackManager.pop();
              }
            },
            child: Text(_localization.admin_leave_detail_button_approve, style: AppTextStyle.subtitleText,),
          ),
        ],
      ),
    );
  }
}
