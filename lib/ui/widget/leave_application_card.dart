import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/user_profile_image.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../data/configs/space_constant.dart';
import '../../data/core/utils/date_formatter.dart';
import '../../data/model/employee/employee.dart';
import '../../data/model/leave_application.dart';
import 'leave_card_status_view.dart';

class LeaveApplicationCard extends StatelessWidget {
  final void Function()? onTap;
  final LeaveApplication leaveApplication;

  const LeaveApplicationCard(
      {Key? key, required this.leaveApplication, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppTheme.commonBorderRadius,
        color: context.colorScheme.containerLow,
      ),
      child: Material(
        borderRadius: AppTheme.commonBorderRadius,
        color: context.colorScheme.containerLow,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(primaryHorizontalSpacing),
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
                        LeaveStatusView(status: leaveApplication.leave.status),
                        const SizedBox(
                          height: 10,
                        ),
                        _LeaveDateContent(
                          firstDayDuration:
                              leaveApplication.leave.perDayDuration.first,
                          totalDays: leaveApplication.leave.total,
                          startDate: leaveApplication.leave.startDate,
                          endDate: leaveApplication.leave.endDate,
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )
                  ],
                ),
                const Divider(height: 30),
                _EmployeeContent(
                  employee: leaveApplication.employee,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LeaveDateContent extends StatelessWidget {
  final double totalDays;
  final LeaveDayDuration firstDayDuration;
  final DateTime startDate;
  final DateTime endDate;

  const _LeaveDateContent(
      {Key? key,
      required this.totalDays,
      required this.startDate,
      required this.endDate,
      required this.firstDayDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String duration = DateFormatter(AppLocalizations.of(context))
        .dateInLine(startDate: startDate, endDate: endDate);
    String days = DateFormatter(AppLocalizations.of(context))
        .getLeaveDurationPresentation(
            totalLeaves: totalDays, firstDayDuration: firstDayDuration);

    return Text(
      '$days, $duration ',
      style:
          AppTextStyle.style16.copyWith(color: context.colorScheme.textPrimary),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _EmployeeContent extends StatelessWidget {
  final Employee employee;

  const _EmployeeContent({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageProfile(
          radius: 25,
          imageUrl: employee.imageUrl,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                employee.name,
                style: AppTextStyle.style16
                    .copyWith(color: context.colorScheme.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              ValidateWidget(
                isValid: employee.employeeId.isNotNullOrEmpty,
                child: Text(
                  employee.employeeId ?? '',
                  style: AppTextStyle.style16
                      .copyWith(color: context.colorScheme.textSecondary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
