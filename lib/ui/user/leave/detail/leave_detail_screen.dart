import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';
import 'package:projectunity/core/utils/date_formatter.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/ui/user/leave/detail/widget/aprroval_status_tag.dart';
import 'package:projectunity/ui/user/leave/detail/widget/leave_action_button.dart';

import '../../../../configs/colors.dart';
import '../../../../widget/Leave_details_screen_widgets/leave_details_header_content.dart';
import '../../../../widget/Leave_details_screen_widgets/reason_content.dart';
import '../../../../widget/Leave_details_screen_widgets/remaining_leave_content.dart';

class UserLeaveDetailScreen extends StatelessWidget {
  final Leave leave;
  const UserLeaveDetailScreen({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    final UserManager _userManager = getIt<UserManager>();
    String appliedTime =
        DateFormatter(_localization).timeAgoPresentation(leave.appliedOn);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text(
            _localization.leave_detail_title,
            style: AppTextStyle.appBarTitle,
          ),
        ),
        body: ListView(
          children: [
            LeaveTypeAgoTitle(timeAgo: appliedTime, leaveType: leave.leaveType),
            const SizedBox(
              height: primaryHorizontalSpacing,
            ),
            RemainingLeaveContainer(
                leave: leave, employeeId: _userManager.employeeId),
            ReasonField(
              reason: leave.reason,
            ),
            ApprovalStatusTag(
                leaveStatus: leave.leaveStatus,
                rejectionReason: leave.rejectionReason),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (leave.leaveStatus != approveLeaveStatus ||
                leave.startDate > DateTime.now().timeStampToInt)
            ? LeaveActionButton(leave: leave,)
            : null);
  }
}


