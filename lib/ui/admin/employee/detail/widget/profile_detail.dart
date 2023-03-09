import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import '../../../../../../configs/text_style.dart';
import '../../../../../../model/employee/employee.dart';
import '../../../../../configs/colors.dart';
import '../../../../../navigation/app_router.dart';
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
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_email_tag,
            subtitle: employee.email),
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_mobile_tag,
            subtitle: employee.phone),
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_blood_group_tag,
            subtitle: employee.bloodGroup),
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_dateOfJoin_tag,
            subtitle: employee.dateOfJoining == null
                ? null
                : localization
                    .date_format_yMMMd(employee.dateOfJoining!.toDate)),
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_dateOfBirth_tag,
            subtitle: employee.dateOfBirth == null
                ? null
                : localization.date_format_yMMMd(employee.dateOfBirth!.toDate)),
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_gender_tag,
            subtitle: employee.gender == null
                ? null
                : localization.user_details_gender(employee.gender!)),
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_address_tag,
            subtitle: employee.address),
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 12,
                    backgroundColor: AppColors.primaryDarkYellow,
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
                  IconButton(
                    icon: const Icon(
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
