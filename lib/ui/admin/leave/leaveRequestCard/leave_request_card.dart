import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/font_size.dart';
import '../../../../utils/const/other_constant.dart';
import 'employee_content.dart';

class LeaveRequestCard extends StatelessWidget {

  const LeaveRequestCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: primaryHorizontalSpacing,
        right: primaryHorizontalSpacing,
        top: primaryHorizontalSpacing,
      ),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLeaveTypeContent(),
          buildLeaveDateContent(),
          Divider(color: Colors.grey.shade300),
          const EmployeeContent(),
          const SizedBox(
            height: 10,
          )
          // const ButtonContent()
        ],
      ),
    );
  }

  Text buildLeaveDateContent() {
    return const Text(
      '7 Days ⚈ Nov 19 - 26, 2022 ',
      style: TextStyle(color: AppColors.secondaryText, fontSize: bodyTextSize),
    );
  }

  Text buildLeaveTypeContent() {
    return const Text(
      'Sick Leave',
      style: TextStyle(
          color: AppColors.darkText,
          fontSize: subTitleTextSize,
          fontWeight: FontWeight.w500),
    );
  }
}
