import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/widget/user_profile_image.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';
import '../../../../../model/employee/employee.dart';

class EmployeeContent extends StatelessWidget {
  Employee employee;

  EmployeeContent({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return Row(
      children: [
        ImageProfile(
          iconSize: 50,
          imageUrl: employee.imageUrl,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                employee.name,
                style: AppTextStyle.darkSubtitle700.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${_localization.employee_employeeID_tag}: ${employee.employeeId}',
                style: AppTextStyle.secondaryBodyText,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              _localization.admin_leave_detail_daysLeft_tag,
              style: AppTextStyle.darkSubtitle700.copyWith(fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 5,
            ),
            Text(
              //TODO :Add actual remaining leaves(21) from total leaves(30)
              '21/30',
              style: AppTextStyle.secondaryBodyText,
            ),
          ],
        ),
      ],
    );
  }
}