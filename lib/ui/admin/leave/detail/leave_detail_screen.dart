import 'package:flutter/material.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/leave_detail_content.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/leave_title_row.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/leaves_left_content.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/user_content.dart';

import '../../../../configs/colors.dart';
import '../../../../utils/const/other_constant.dart';
import 'widget/button_content.dart';

class AdminLeaveRequestDetailScreen extends StatefulWidget {
  const AdminLeaveRequestDetailScreen({Key? key}) : super(key: key);

  @override
  State<AdminLeaveRequestDetailScreen> createState() =>
      _AdminLeaveRequestDetailScreenState();
}

class _AdminLeaveRequestDetailScreenState
    extends State<AdminLeaveRequestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.darkText,
          ),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: primaryHorizontalSpacing,
            right: primaryHorizontalSpacing,
            bottom: 10),
        child: Column(
          children: [
            UserContent(),
            LeavesLeftContent(),
            Divider(color: AppColors.secondaryText),
            LeaveTitleRow(),
            LeaveDetailContent(),
            ButtonContent(),
          ],
        ),
      ),
    );
  }
}
