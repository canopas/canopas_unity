import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';
import '../../../../../model/employee/employee.dart';

class EmployeeContent extends StatelessWidget {
  Employee employee;

  EmployeeContent({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/angelaYu.jpeg'),
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
                style: const TextStyle(
                    fontSize: subTitleTextSize,
                    color: AppColors.darkText,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Employee ID: ${employee.employeeId}',
                style: const TextStyle(
                    fontSize: bodyTextSize, color: AppColors.secondaryText),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              'Days Left',
              style: TextStyle(
                  fontSize: subTitleTextSize,
                  color: AppColors.darkText,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '21/30',
              style: TextStyle(
                  fontSize: bodyTextSize, color: AppColors.secondaryText),
            ),
          ],
        ),
      ],
    );
  }
}
