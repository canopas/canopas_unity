import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/extensions/double_extension.dart';
import 'package:projectunity/data/model/leave_count.dart';
import 'package:projectunity/ui/widget/leave_count_view.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../navigation/app_router.dart';

class TimeOffCard extends StatelessWidget {
  const TimeOffCard({
    Key? key,
    required this.percentage,
    required this.usedLeaves,
    required this.employee,
  }) : super(key: key);
  final Employee employee;
  final double percentage;
  final LeaveCounts usedLeaves;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: primaryVerticalSpacing,
          horizontal: primaryHorizontalSpacing),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      child: Material(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: () => context
              .goNamed(Routes.adminEmployeeDetailsLeaves, pathParameters: {
            RoutesParamsConst.employeeId: employee.uid,
            RoutesParamsConst.employeeName: employee.name,
          }),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerColor),
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
                          backgroundColor: AppColors.lightPrimaryBlue,
                          color: AppColors.primaryBlue,
                          value: percentage,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .admin_employees_detail_time_off_tag,
                          style: AppFontStyle.labelGrey,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          usedLeaves.totalUsedLeave.fixedAt(2).toString(),
                          style: AppFontStyle.titleRegular,
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.greyColor,
                          size: 20,
                        ),
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
