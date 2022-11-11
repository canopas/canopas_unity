import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';

import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/const/leave_map.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../model/leave_count.dart';
import '../../../../../navigation/nav_stack/nav_stack_item.dart';
import 'employee_content.dart';

class LeaveRequestCard extends StatelessWidget {
  final LeaveApplication leaveApplication;
  final _stackManager = getIt<NavigationStackManager>();

  LeaveRequestCard({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Leave leave = leaveApplication.leave;
    Color? color = leaveRequestCardColor[leaveApplication.leave.leaveType];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: primaryVerticalSpacing, horizontal: primaryHorizontalSpacing),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.20),
            offset: const Offset(0,0),
            spreadRadius: 2,
            blurRadius: 5,
          )
        ]
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            _stackManager.push(
                NavStackItem.leaveDetailState(leaveApplication));
          },
          child: Row(
            children: [
              Container(
                height: 175,
              width: 6,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))
              ),),
              Padding(
                padding: const EdgeInsets.all(primaryHorizontalSpacing),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 70,
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
                                    leaveType: leave.leaveType, context: context),
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
                           const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: AppColors.greyColor,
                          )
                        ],
                      ),
                      const Divider(
                          thickness: 0.5,
                          height:30,
                          color: AppColors.greyColor),
                      EmployeeContent(
                        employee: leaveApplication.employee,
                        leaveCounts:
                            leaveApplication.leaveCounts ?? LeaveCounts(),
                      ),

                      // const ButtonContent()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLeaveTypeContent(
      {required int leaveType, required BuildContext context}) {
    Color? color = leaveRequestCardColor[leaveType];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color!,
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5, horizontal: primaryVerticalSpacing),
      child: Text(
        AppLocalizations.of(context)
            .leave_type_placeholder_leave_status(leaveType),
        style: AppTextStyle.subtitleText
            .copyWith(fontWeight: FontWeight.w500, color: AppColors.whiteColor),
      ),
    );
  }

  Text buildLeaveDateContent(
      {required double totalDays,
      required int startTimeStamp,
      required int endTimeStamp,
      required BuildContext context}) {
    String duration = DateFormatter(AppLocalizations.of(context))
        .dateInLine(
            startTimeStamp: startTimeStamp, endTimeStamp: endTimeStamp);
    String days = DateFormatter(AppLocalizations.of(context))
        .getLeaveDurationPresentation(totalDays);

    return Text(
      '$days, $duration ',
      style: AppTextStyle.secondaryBodyText,
      overflow: TextOverflow.ellipsis,
    );
  }
}
