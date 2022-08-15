import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/font_size.dart';

import '../../../../../../model/employee/employee.dart';

class ProfileDetail extends StatelessWidget {
  final Employee employee;

  const ProfileDetail({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Details(
          title: _localization.employee_role_tag,
          subTitle: employee.getRole(),
        ),
        Details(
          title: _localization.employee_mobile_tag,
          subTitle: employee.phone,
        ),
        Details(
            title: _localization.employee_email_tag, subTitle: employee.email),
        Details(
            title: _localization.employee_address_tag,
            subTitle: employee.address),
        Details(
          title: _localization.employee_dateOfBirth_tag,
          subTitle: employee.dateOfBirth.toString(),
        ),
        Details(
          title: _localization.employee_dateOfJoin_tag,
          subTitle: employee.dateOfJoining.toString(),
        ),
        Details(
            title: _localization.employee_employeeID_tag,
            subTitle: employee.employeeId)
      ],
    );
  }
}

class DetailDivider extends StatelessWidget {
  const DetailDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 25,
      endIndent: 25,
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title:',
                style: const TextStyle(
                    fontSize: titleTextSize, color: Colors.grey),
              ),
              Text(
                subTitle ?? '-',
                style: const TextStyle(
                    fontSize: titleTextSize, color: Colors.black),
              ),
            ],
          ),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }
}
