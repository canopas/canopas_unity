import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigationStackItem/employee/employee_navigation_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';
import '../../../../../core/utils/const/leave_map.dart';
import '../../../../../core/utils/date_string_utils.dart';
import '../../../../../model/leave/leave.dart';
import 'leave_date_container.dart';

Color getContainerColor(int status) {
  if (status == 2) {
    return AppColors.primaryDarkYellow;
  } else if (status == 3) {
    return AppColors.blackColor;
  }
  return AppColors.lightGreyColor;
}

class LeaveCard extends StatelessWidget {
  final Leave leave;
  final _stateManager = getIt<NavigationStackManager>();

  LeaveCard({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = getContainerColor(leave.leaveStatus);
    final String _leaveType = getLeaveStatus(leave.leaveType, leaveTypeMap);
    final String _leaveStatus =
        getLeaveStatus(leave.leaveStatus, leaveStatusMap);
    return Column(
      children: [
        InkWell(
          onTap: () => _stateManager
              .push(EmployeeNavigationStackItem.leaveDetailState(leave)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BuildLeaveDateContainer(
                startDate: leave.startDate,
                endDate: leave.endDate,
                color: _color,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: SizedBox(
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _leaveType,
                        style: const TextStyle(
                            color: AppColors.darkText,
                            fontSize: subTitleTextSize,
                            fontWeight: FontWeight.w700),
                      ),
                      _buildReason(),
                      const SizedBox(
                        height: 5,
                      ),
                      _buildLeaveStatus(leaveStatusText: _leaveStatus),
                      //  if (leave.rejectionReason != null) _buildRejectionCause(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  RichText _buildRejectionCause() {
    return RichText(
        softWrap: true,
        overflow: TextOverflow.visible,
        text: TextSpan(
            text: 'Reason: ',
            style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: subTitleTextSize,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                  text: leave.rejectionReason,
                  style: const TextStyle(
                      color: AppColors.secondaryText, fontSize: bodyTextSize))
            ]));
  }

  Widget _buildReason() {
    return Text(
      leave.reason,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: const TextStyle(
          fontSize: bodyTextSize, color: AppColors.secondaryText),
    );
  }

  Widget _buildLeaveStatus({required String leaveStatusText}) {
    return Row(
      children: [
        if (leave.leaveStatus == pendingLeaveStatus)
          const Icon(
            Icons.error,
            color: AppColors.secondaryText,
          )
        else if (leave.leaveStatus == rejectLeaveStatus)
          const Icon(
            Icons.dangerous,
            color: AppColors.primaryPink,
          )
        else if (leave.leaveStatus == approveLeaveStatus)
          const Icon(
            Icons.check_circle,
            color: AppColors.primaryGreen,
          ),
        Text(
          leaveStatusText,
          style: const TextStyle(
              color: AppColors.darkText, fontSize: bodyTextSize),
        )
      ],
    );
  }
}
