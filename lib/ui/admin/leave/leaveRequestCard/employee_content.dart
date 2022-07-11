import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/font_size.dart';

class EmployeeContent extends StatelessWidget {
  const EmployeeContent({
    Key? key,
  }) : super(key: key);

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
            children: const [
              Text(
                'Thomas Richards',
                style: TextStyle(
                    fontSize: subTitleTextSize,
                    color: AppColors.darkText,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Employee ID: CA-1044',
                style: TextStyle(
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
