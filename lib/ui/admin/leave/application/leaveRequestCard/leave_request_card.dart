import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
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
  LeaveApplication employeeLeave;
  final _stackManager = getIt<NavigationStackManager>();

  LeaveRequestCard({Key? key, required this.employeeLeave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Leave leave = employeeLeave.leave;

    return Container(
      padding: const EdgeInsets.only(
        left: primaryHorizontalSpacing,
        right: primaryHorizontalSpacing,
        top: primaryHorizontalSpacing,
      ),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onPressed: () {
                  _stackManager.push(
                      AdminNavigationStackItem.adminLeaveRequestDetailState(
                          employeeLeave));
                },
              )
            ],
          ),
          Divider(color: Colors.grey.shade300),
          EmployeeContent(
            employee: employeeLeave.employee,
          ),
          const SizedBox(
            height: 10,
          )
          // const ButtonContent()
        ],
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
    String days = totalLeaves(totalDays);

    return Text(
      '$days  ⚈ $date ',
      style: AppTextStyle.secondaryBodyText,
    );
  }

  Widget buildLeaveTypeContent(
      {required int leaveType, required BuildContext context}) {
    return Text(
      AppLocalizations.of(context)
          .leave_type_placeholder_leave_status(leaveType),
      style: AppTextStyle.darkSubtitle700.copyWith(fontWeight: FontWeight.w500),
    );
  }
}



