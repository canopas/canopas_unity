import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/leave_map.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../navigation/app_router.dart';
import '../../../../../widget/circular_progress_indicator.dart';
import '../../../../../widget/empty_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LeaveList extends StatelessWidget {
  final String employeeName;
  final bool isLoading;
  final List<Leave> leaves;
  final String emptyStringTitle;
  final String emptyStringMessage;

  const LeaveList(
      {Key? key,
        required this.isLoading,
        required this.leaves,
        required this.emptyStringTitle,
        required this.emptyStringMessage, required this.employeeName})
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
            onTap: () {
              context.goNamed(Routes.adminEmployeeDetailsLeavesDetails,
              params: {
                RoutesParamsConst.employeeId : leaves[leave].uid,
                RoutesParamsConst.leaveId : leaves[leave].leaveId,
                RoutesParamsConst.employeeName : employeeName,
              });
        },
        leave: leaves[leave],
      ),
      separatorBuilder: (BuildContext context, int index) =>
      const SizedBox(height: 16),
    );
  }
}

class LeaveCard extends StatelessWidget {
  final bool hideStatus;
  final Leave leave;
  final void Function()? onTap;

  const LeaveCard(
      {Key? key,required this.onTap,required this.leave, this.hideStatus = false})
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
          onTap: onTap,
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
                          .getLeaveDurationPresentation(leave.totalLeaves)
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
                        color: leaveStatusColor(leave.leaveStatus),
                      ),
                      child: Text(AppLocalizations.of(context)
                          .leave_status_placeholder_text(
                          leave.leaveStatus.toString())),
                    ),
                  ],
                ),
                const Divider(color: AppColors.dividerColor, height:32,thickness: 1, indent: 0, endIndent: 0),
                Text(
                    DateFormatter(AppLocalizations.of(context)).dateInLine(
                        startTimeStamp: leave.startDate,
                        endTimeStamp: leave.endDate),
                    style: AppFontStyle.bodyMedium),
                const SizedBox(height: 8),
                Text(
                    AppLocalizations.of(context).leave_type_placeholder_text(
                        leave.leaveType.toString()),
                    style: AppFontStyle.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}