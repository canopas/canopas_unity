import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';

import '../../../../../../configs/text_style.dart';
import '../../../../../../model/employee/employee.dart';

class ProfileDetail extends StatelessWidget {
  final Employee employee;

  const ProfileDetail({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EmployeeField(
          title: localization.employee_mobile_tag,
          subtitle: employee.phone,
        ),
        EmployeeField(
            title: localization.employee_email_tag,
            subtitle: employee.email),
        EmployeeField(
          title: localization.employee_dateOfJoin_tag,
          subtitle: (employee.dateOfJoining != null)?localization.date_format_yMMMd(employee.dateOfJoining!.toDate):" - ",
        ),
        EmployeeField(
          title: localization.employee_level_tag,
          subtitle: employee.level,
        ),
      ],
    );
  }
}
class EmployeeField extends StatelessWidget {
  const EmployeeField({Key? key, required this.title, required this.subtitle}) : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(primaryHorizontalSpacing).copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.secondarySubtitle500),
          const SizedBox(height: 6),
          Text((subtitle == 'null')?'-':subtitle ??"-", style: AppTextStyle.titleText,),
        ],
      ),
    );
  }
}



