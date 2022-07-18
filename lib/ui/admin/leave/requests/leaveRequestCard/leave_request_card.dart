import 'package:flutter/material.dart';
import 'package:projectunity/navigation/navigation_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../utils/const/other_constant.dart';
import 'employee_content.dart';

class LeaveRequestCard extends StatelessWidget {
  final _stackManager = getIt<NavigationStackManager>();

  LeaveRequestCard({
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLeaveTypeContent(),
                  const SizedBox(
                    height: 10,
                  ),
                  buildLeaveDateContent(),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onPressed: () {
                  _stackManager.push(
                      const NavigationStackItem.adminLeaveRequestDetailState());
                },
              )
            ],
          ),

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

  Widget buildLeaveTypeContent() {
    return const Text(
      'Sick Leave',
      style: TextStyle(
          color: AppColors.darkText,
          fontSize: subTitleTextSize,
          fontWeight: FontWeight.w500),
    );
  }
}
