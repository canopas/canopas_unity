import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../widget/employee_details_field.dart';

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
            title: AppLocalizations.of(context).employee_dateOfJoin_tag,
            subtitle: localization.date_format_yMMMd(employee.dateOfJoining)),
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_dateOfBirth_tag,
            subtitle: employee.dateOfBirth == null
                ? null
                : localization.date_format_yMMMd(employee.dateOfBirth!)),
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_gender_tag,
            subtitle: employee.gender == null
                ? null
                : localization.user_details_gender(employee.gender!.value)),
        EmployeeDetailsField(
            title: AppLocalizations.of(context).employee_address_tag,
            subtitle: employee.address),
      ],
    );
  }
}

