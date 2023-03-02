import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/core/extensions/date_time.dart';

import '../../../../../../configs/text_style.dart';
import '../../../../../../model/employee/employee.dart';
import '../../../../../configs/colors.dart';
import '../../../../../router/app_router.dart';

class ProfileDetail extends StatelessWidget {
  final Employee employee;
  final int paidLeaves;
  final double usedLeaves;
  final double percentage;

  const ProfileDetail(
      {Key? key,
      required this.employee,
      required this.usedLeaves,
      required this.paidLeaves,
      required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TimeOffCard(
            percentage: percentage,
            usedLeaves: usedLeaves,
            paidLeaves: paidLeaves,
            employeeId: employee.id),
        EmployeeField(
          title: localization.employee_mobile_tag,
          subtitle: employee.phone,
        ),
        EmployeeField(
            title: localization.employee_email_tag, subtitle: employee.email),
        EmployeeField(
          title: localization.employee_dateOfJoin_tag,
          subtitle: (employee.dateOfJoining != null)
              ? localization.date_format_yMMMd(employee.dateOfJoining!.toDate)
              : " - ",
        ),
        EmployeeField(
          title: localization.employee_level_tag,
          subtitle: employee.level,
        ),
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
                    ),
                    onPressed: () => context.goNamed(
                        Routes.userCalenderForAdmin,
                        params: {RoutesParamsConst.employeeId: employeeId}),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeField extends StatelessWidget {
  const EmployeeField({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return (subtitle == null)
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(primaryHorizontalSpacing)
                .copyWith(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFontStyle.labelGrey,
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle!,
                  style: AppFontStyle.titleRegular,
                ),
              ],
            ),
          );
  }
}
