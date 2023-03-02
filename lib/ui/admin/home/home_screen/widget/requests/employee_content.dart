import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/widget/user_profile_image.dart';

import '../../../../../../model/employee/employee.dart';

class EmployeeContent extends StatelessWidget {
  final Employee employee;

  const EmployeeContent({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageProfile(
          borderColor: AppColors.blackColor,
          borderSize: 1,
          radius: 25,
          imageUrl: employee.imageUrl,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              employee.name,
              style: AppFontStyle.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              employee.employeeId,
              style: AppFontStyle.subTitleGrey,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
