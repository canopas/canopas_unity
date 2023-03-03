import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import '../../../../../../configs/text_style.dart';
import '../../../../../../model/employee/employee.dart';
import '../../../../../configs/colors.dart';
import '../../../../../router/app_router.dart';
import '../../../../../widget/employee_details_field.dart';

class ProfileDetail extends StatelessWidget {
  final Employee employee;

  const ProfileDetail({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...{
          AppLocalizations.of(context).employee_email_tag: employee.email,
          AppLocalizations.of(context).employee_mobile_tag: employee.phone,
          AppLocalizations.of(context).employee_blood_group_tag: employee.bloodGroup,
          AppLocalizations.of(context).employee_dateOfJoin_tag:
              employee.dateOfJoining == null
                  ? null
                  : localization.date_format_yMMMd(employee.dateOfJoining!.toDate),
          AppLocalizations.of(context).employee_dateOfBirth_tag:
              employee.dateOfBirth == null
                  ? null
                  : localization.date_format_yMMMd(employee.dateOfBirth!.toDate),
          AppLocalizations.of(context).employee_gender_tag:
              employee.gender == null
                  ? null
                  : localization.user_details_gender(employee.gender!),
          AppLocalizations.of(context).employee_address_tag: employee.address
        }.entries.where((element) => element.value != null)
            .map((detail) => EmployeeDetailsField(
                title: detail.key,
                subtitle: detail.value.toString(),
              ),
            ).toList(),
      ],
    );
  }
}

class TimeOffCard extends StatelessWidget {
  const TimeOffCard({
    Key? key,
    required this.percentage,
    required this.usedLeaves,
    required this.paidLeaves,
    required this.employeeId,
  }) : super(key: key);

  final double percentage;
  final double usedLeaves;
  final int paidLeaves;
  final String employeeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: primaryVerticalSpacing,horizontal: primaryHorizontalSpacing),
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow
      ),
      child: Material(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: () => context.goNamed(
              Routes.userCalenderForAdmin,
              params: {RoutesParamsConst.employeeId: employeeId}),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
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
                      '$usedLeaves/$paidLeaves',
                      style: AppFontStyle.titleRegular,
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.greyColor,
                      size: 20,
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
