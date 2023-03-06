import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/leave_screen_type_map.dart';
import '../../../../../core/utils/date_formatter.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../model/leave_application.dart';
import '../../../../../widget/circular_progress_indicator.dart';
import '../../../../../widget/empty_screen.dart';

class LeaveList extends StatelessWidget {
  final bool isLoading;
  final List<Leave> leaves;
  final Employee employee;
  final String emptyStringTitle;
  final String emptyStringMessage;

  const LeaveList(
      {Key? key,
        required this.isLoading,
        required this.leaves,
        required this.employee,
        required this.emptyStringTitle,
        required this.emptyStringMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const AppCircularProgressIndicator()
        : leaves.isEmpty
        ? EmptyScreen(message: emptyStringMessage, title: emptyStringTitle)
        : ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: leaves.length,
      itemBuilder: (context, leave) => LeaveCard(
        leaveApplication: LeaveApplication(
            leave: leaves[leave], employee: employee),
      ),
      separatorBuilder: (BuildContext context, int index) =>
      const SizedBox(height: 16),
    );
  }
}

class LeaveCard extends StatelessWidget {
  final bool hideStatus;
  final LeaveApplication leaveApplication;

  const LeaveCard(
      {Key? key, required this.leaveApplication, this.hideStatus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: Material(
        borderRadius: AppTheme.commonBorderRadius,
        color: AppColors.whiteColor,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormatter(AppLocalizations.of(context))
                          .getLeaveDurationPresentation(
                          leaveApplication.leave.totalLeaves)
                          .toString(),
                      style: AppFontStyle.bodySmallRegular,
                    ),
                    hideStatus
                        ? const SizedBox()
                        : Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: getLeaveContainerColor(
                            leaveApplication.leave.leaveStatus),
                      ),
                      child: Text(AppLocalizations.of(context)
                          .leave_status_placeholder_text(
                          leaveApplication.leave.leaveStatus.toString())),
                    ),
                  ],
                ),
                const Divider(color: AppColors.dividerColor, height:32,thickness: 1, indent: 0, endIndent: 0),
                Text(
                    DateFormatter(AppLocalizations.of(context)).dateInLine(
                        startTimeStamp: leaveApplication.leave.startDate,
                        endTimeStamp: leaveApplication.leave.endDate),
                    style: AppFontStyle.bodyMedium),
                const SizedBox(height: 8),
                Text(
                    AppLocalizations.of(context).leave_type_placeholder_leave_status(
                        leaveApplication.leave.leaveType.toString()),
                    style: AppFontStyle.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

