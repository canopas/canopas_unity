import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';

import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/const/other_constant.dart';
import '../../../../../core/utils/date_string_utils.dart';
import '../../../../../navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import 'employee_content.dart';

class LeaveRequestCard extends StatelessWidget {
  final LeaveApplication leaveApplication;
  final _stackManager = getIt<NavigationStackManager>();

  LeaveRequestCard({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Leave leave = leaveApplication.leave;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        _stackManager.push(
            AdminNavigationStackItem.adminLeaveRequestDetailState(
                leaveApplication));
      },
      child: Container(
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primaryBlue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLeaveTypeContent(
                          leaveType: leave.leaveType ?? 1, context: context),
                      const SizedBox(
                        height: 10,
                      ),
                      buildLeaveDateContent(
                          totalDays: leave.totalLeaves,
                          startTimeStamp: leave.startDate,
                          endTimeStamp: leave.endDate,
                          context: context),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: AppColors.primaryBlue,
                  ),
                )
              ],
            ),
            const Divider(
                height:30,
                color: AppColors.primaryBlue),
            EmployeeContent(
              employee: leaveApplication.employee,
            ),

            // const ButtonContent()
          ],
        ),
      ),
    );
  }

  Text buildLeaveDateContent(
      {required double totalDays,
        required int startTimeStamp,
        required int endTimeStamp,
        required BuildContext context}) {
    String localeName = AppLocalizations.of(context).localeName;
    String date = dateInSingleLine(
        startTimeStamp: startTimeStamp,
        endTimeStamp: endTimeStamp,
        locale: localeName);
    String days = daysFinder(totalDays);

    return Text(
      '$days  ⚈ $date ',
      style: AppTextStyle.secondaryBodyText,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildLeaveTypeContent(
      {required int leaveType, required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryBlue.withOpacity(0.15)
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Text(
        AppLocalizations.of(context)
            .leave_type_placeholder_leave_status(leaveType),
        style: AppTextStyle.darkSubtitle700.copyWith(fontWeight: FontWeight.w500, color: AppColors.primaryBlue),
      ),
    );
  }
}



