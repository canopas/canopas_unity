import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/const/leave_map.dart';
import 'package:projectunity/core/utils/const/leave_status.dart';
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
    final String _leaveType =
        getLeaveStatus(leave.leaveStatus, leaveTypeMap) ?? '';
    final _duration = dateInSingleLine(
        startTimeStamp: leave.startDate, endTimeStamp: leave.endDate);
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
        title: const Text(
          'Approval Status',
          style: TextStyle(fontSize: titleTextSize, color: AppColors.darkText),
        ),
        actions: canCancelLeave
            ? [
                TextButton(
                  onPressed: () {
                    _userLeaveService.deleteLeaveRequest(leave.leaveId);
                    showSnackBar(context, 'Leave Application is cancelled!');
                    _stackManager.pop();
                  },
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(
                        fontSize: subTitleTextSize, color: AppColors.blueGrey),
                  ),
                )
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFieldColumn(title: 'Leave Type', value: _leaveType),
              buildDivider(),
              Row(
                children: [
                  Expanded(
                      child: buildFieldColumn(
                          title: 'Duration', value: _duration)),
                  buildFieldColumn(title: ' Total days', value: '⚈ $_totalDays')
                ],
              ),
              buildDivider(),
              buildFieldColumn(title: 'Reason', value: _reason),
              buildDivider(),
              buildFieldColumn(title: 'Approval Status:', value: ''),
              _buildStatus(leave.leaveStatus),
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

Widget _buildStatus(int leaveStatus) {
  switch (leaveStatus) {
    case 1:
      return const PendingStatus();
    case 2:
      return const ApproveStatus();
    case 3:
      return const RejectStatus();
  }
  throw Exception('Something went wrong');
}
