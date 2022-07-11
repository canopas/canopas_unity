import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/utils/const/other_constant.dart';

import '../../../configs/colors.dart';
import 'leaveRequestCard/leave_request_card.dart';

class AdminLeaveRequestsScreen extends StatefulWidget {
  const AdminLeaveRequestsScreen({Key? key}) : super(key: key);

  @override
  State<AdminLeaveRequestsScreen> createState() =>
      _AdminLeaveRequestsScreenState();
}

class _AdminLeaveRequestsScreenState extends State<AdminLeaveRequestsScreen> {
  TextEditingController textEditingController = TextEditingController();

  NavigationStackManager _stackManager = getIt<NavigationStackManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.darkText,
          ),
          onPressed: () {
            _stackManager.pop();
          },
        ),
        title: const Text(
          "Requests",
          style: TextStyle(
              color: AppColors.darkText,
              fontSize: headerTextSize,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: primaryHorizontalSpacing,
            right: primaryHorizontalSpacing,
            left: primaryHorizontalSpacing),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return const LeaveRequestCard();
          },
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        ),
      ),
    );
  }
}
