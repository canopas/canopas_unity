import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/double_extension.dart';
import 'package:projectunity/data/model/leave_count.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/leave_count_view.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../app_router.dart';

class TimeOffCard extends StatelessWidget {
  const TimeOffCard({
    super.key,
    required this.percentage,
    required this.usedLeaves,
    required this.employee,
  });
  final Employee employee;
  final double percentage;
  final LeaveCounts usedLeaves;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: primaryVerticalSpacing,
        horizontal: primaryHorizontalSpacing,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow(context),
      ),
      child: Material(
        color: context.colorScheme.surface,
        borderRadius: AppTheme.commonBorderRadius,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: () => context.goNamed(
            Routes.adminEmployeeDetailsLeaves,
            extra: employee.uid,
            pathParameters: {RoutesParamsConst.employeeName: employee.name},
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colorScheme.outlineColor),
                    borderRadius: AppTheme.commonBorderRadius,
                  ),
                  child: UsedLeaveCountsView(leaveCounts: usedLeaves),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 8,
                          backgroundColor: context.colorScheme.primary
                              .withValues(alpha: 0.5),
                          color: context.colorScheme.primary,
                          value: percentage,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          context.l10n.admin_employees_detail_time_off_tag,
                          style: AppTextStyle.style16.copyWith(
                            color: context.colorScheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          usedLeaves.totalUsedLeave.fixedAt(2).toString(),
                          style: AppTextStyle.style16,
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward_ios_outlined, size: 20),
                      ],
                    ),
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
