import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/configs/theme.dart';
import '../../configs/colors.dart';
import '../../data/core/utils/const/leave_map.dart';
import '../../data/core/utils/date_formatter.dart';
import '../../data/model/leave/leave.dart';

class _LeaveTypeView extends StatelessWidget {
  final int leaveType;

  const _LeaveTypeView({Key? key, required this.leaveType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: leaveRequestCardColor[leaveType],
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Text(
        AppLocalizations.of(context)
            .leave_type_placeholder_text(leaveType.toString()),
        style: AppFontStyle.labelRegular.copyWith(color: AppColors.whiteColor),
      ),
    );
  }
}

class _LeaveStatusView extends StatelessWidget {
  final int status;

  const _LeaveStatusView({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon getLeaveStatusIcon() {
      if (status == approveLeaveStatus) {
        return const Icon(Icons.done_all_rounded,
            color: AppColors.greenColor, size: 20);
      } else if (status == rejectLeaveStatus) {
        return const Icon(Icons.clear_rounded,
            color: AppColors.redColor, size: 20);
      }
      return const Icon(Icons.query_builder,
          color: AppColors.secondaryText, size: 20);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          getLeaveStatusIcon(),
          const SizedBox(width: 5),
          Text(
            AppLocalizations.of(context)
                .leave_status_placeholder_text(status.toString()),
            style: AppFontStyle.labelRegular,
          ),
        ],
      ),
    );
  }
}

class LeaveCard extends StatelessWidget {
  final bool hideStatus;
  final Leave leave;
  final void Function()? onTap;

  const LeaveCard(
      {Key? key,
      required this.onTap,
      required this.leave,
      this.hideStatus = false})
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
                    _LeaveTypeView(leaveType: leave.leaveType),
                    Text(
                      DateFormatter(AppLocalizations.of(context))
                          .getLeaveDurationPresentation(leave.totalLeaves)
                          .toString(),
                      style: AppFontStyle.bodySmallRegular,
                    ),
                  ],
                ),
                const Divider(
                    color: AppColors.dividerColor,
                    height: 32,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormatter(AppLocalizations.of(context))
                                .dateInLine(
                                    startTimeStamp: leave.startDate,
                                    endTimeStamp: leave.endDate),
                            style: AppFontStyle.bodyMedium),
                        hideStatus
                            ? const SizedBox()
                            : _LeaveStatusView(
                                status: leave.leaveStatus,
                              ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
