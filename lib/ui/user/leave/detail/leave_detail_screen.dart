import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/date_string_utils.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:projectunity/ui/user/leave/detail/status_container/approve.dart';
import 'package:projectunity/ui/user/leave/detail/status_container/pending.dart';
import 'package:projectunity/ui/user/leave/detail/status_container/rejected.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'package:projectunity/widget/leave_detail.dart';

import '../../../../configs/colors.dart';

class UserLeaveDetailScreen extends StatelessWidget {
  final Leave leave;
  final _stackManager = getIt<NavigationStackManager>();
  final _userLeaveService = getIt<UserLeaveService>();

  UserLeaveDetailScreen({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    final _duration = dateInSingleLine(
        startTimeStamp: leave.startDate,
        endTimeStamp: leave.endDate,
        locale: _localization.localeName);
    final _totalDays = totalLeaves(leave.totalLeaves);
    final String _reason = leave.reason;
    final String? _rejectionReason = leave.rejectionReason;
    var currentTimeStamp = DateTime.now().timeStampToInt;

    bool canCancelLeave = leave.leaveStatus == pendingLeaveStatus ||
        leave.startDate >= currentTimeStamp;
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
          onPressed: () => _stackManager.pop(),
        ),
        title: Text(
          _localization.user_leave_detail_approval_Status_tag,
          style: AppTextStyle.appBarTitle,
        ),
        actions: canCancelLeave
            ? [
                TextButton(
                  onPressed: () {
                    _userLeaveService.deleteLeaveRequest(leave.leaveId);
                    showSnackBar(context, 'Leave Application is cancelled!');
                    _stackManager.pop();
                  },
                  child: Text(
              _localization.user_leave_detail_button_cancel,
                    style: AppTextStyle.leaveDetailSubtitle,
            ),
          )
        ]: null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFieldColumn(
                  title: _localization.leave_type_tag,
                  value: _localization
                      .leave_type_placeholder_leave_status(leave.leaveStatus)),
              buildDivider(),
              Row(
                children: [
                  Expanded(
                      child: buildFieldColumn(
                          title: _localization.leave_duration_text,
                          value: _duration)),
                  buildFieldColumn(
                      title: _localization.leave_totalDays_tag,
                      value: '⚈ $_totalDays')
                ],
              ),
              buildDivider(),
              buildFieldColumn(
                  title: _localization.leave_reason_tag, value: _reason),
              buildDivider(),
              buildFieldColumn(
                  title:
                      '${_localization.user_leave_detail_approval_Status_tag}:',
                  value: ''),
              _buildStatus(leave.leaveStatus, context),
              _rejectionReason != null
                  ? buildFieldColumn(title: '', value: _rejectionReason)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStatus(int leaveStatus, BuildContext context) {
  switch (leaveStatus) {
    case 1:
      return const PendingStatus();
    case 2:
      return const ApproveStatus();
    case 3:
      return const RejectStatus();
  }
  throw Exception(AppLocalizations.of(context).error_something_went_wrong);
}
