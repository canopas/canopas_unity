import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../model/employee/employee.dart';
import '../../../../../widget/employee_details_field.dart';
import '../../../../admin/employee/detail/widget/profile_detail.dart';

class EmployeeInfo extends StatelessWidget {
  final Employee employee;
  const EmployeeInfo({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EmployeeDetailsField(
          title: localization.employee_mobile_tag,
          subtitle: employee.phone,
        ),
        EmployeeDetailsField(
            title: localization.employee_email_tag, subtitle: employee.email),
        EmployeeDetailsField(
          title: localization.employee_level_tag,
          subtitle: employee.level,
        ),
      ],
    );
  }
}
