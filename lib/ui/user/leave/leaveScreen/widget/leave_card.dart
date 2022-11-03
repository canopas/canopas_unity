import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import '../../../../../configs/colors.dart';
import '../../../../../core/utils/const/leave_screen_type_map.dart';
import '../../../../../model/leave/leave.dart';
import 'leave_date_container.dart';

class LeaveCard extends StatelessWidget {
  final LeaveApplication leaveApplication;
  final _stateManager = getIt<NavigationStackManager>();

  LeaveCard({Key? key, required this.leaveApplication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = getLeaveContainerColor(leaveApplication.leave.leaveStatus);
    final localize = AppLocalizations.of(context);
    return InkWell(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
      onTap: () => _stateManager.push(NavStackItem.leaveDetailState(leaveApplication)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BuildLeaveDateContainer(
            startDate: leaveApplication.leave.startDate,
            endDate: leaveApplication.leave.endDate,
            color: color,
          ),
          Expanded(
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(primaryHorizontalSpacing),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localize
                          .leave_type_placeholder_leave_status(leaveApplication.leave.leaveType),
                      style: AppTextStyle.darkSubtitle700,
                    ),
                    const SizedBox(height: 5),
                    _buildReason(),
                    const Spacer(),
                    const SizedBox(
                      height: 4,
                    ),
                    _leaveStatusIcon(
                        leaveStatusText: localize
                            .leave_status_placeholder_text(leaveApplication.leave.leaveStatus)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget _buildReason() {
    return Text(
      leaveApplication.leave.reason,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: AppTextStyle.secondaryBodyText,
    );
  }

  Widget _leaveStatusIcon({required String leaveStatusText}) {
    return Row(
      children: [
        if (leaveApplication.leave.leaveStatus == pendingLeaveStatus)
          const Icon(
            Icons.error,
            color: AppColors.secondaryText,
          )
        else if (leaveApplication.leave.leaveStatus == rejectLeaveStatus)
          const Icon(
            Icons.dangerous,
            color: AppColors.primaryPink,
          )
        else if (leaveApplication.leave.leaveStatus == approveLeaveStatus)
          const Icon(
            Icons.check_circle,
            color: AppColors.primaryGreen,
          ),
        const SizedBox(width: 5,),
        Text(
          leaveStatusText,
          style: AppTextStyle.bodyTextDark,
        )
      ],
    );
  }
}
