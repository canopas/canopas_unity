import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/date_string_utils.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/user/leave/detail/status_container/approve.dart';
import 'package:projectunity/ui/user/leave/detail/status_container/pending.dart';
import 'package:projectunity/ui/user/leave/detail/status_container/rejected.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'package:projectunity/widget/leave_detail.dart';

import '../../../../bloc/user/user_leave_bloc.dart';
import '../../../../configs/colors.dart';

class UserLeaveDetailScreen extends StatelessWidget {
  final Leave leave;
  const UserLeaveDetailScreen({Key? key, required this.leave}) : super(key: key);

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

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text(
            _localization.leave_detail_title,
            style: AppTextStyle.appBarTitle,
          ),
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
                        .leave_type_placeholder_leave_status(leave.leaveType)),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (leave.leaveStatus != approveLeaveStatus ||
                leave.startDate > DateTime.now().timeStampToInt)
            ? _LeaveActionButton(leave: leave,)
            : null);
  }
}

Widget _buildStatus(int leaveStatus, BuildContext context) {
  switch (leaveStatus) {
    case pendingLeaveStatus:
      return const PendingStatus();
    case approveLeaveStatus:
      return const ApproveStatus();
    case rejectLeaveStatus:
      return const RejectStatus();
  }
  throw Exception(AppLocalizations.of(context).error_something_went_wrong);
}

///
/// leave details screen floating action button.
///
class _LeaveActionButton extends StatelessWidget {
  _LeaveActionButton({Key? key, required this.leave}) : super(key: key);
  final Leave leave;
  final UserLeavesBloc _userLeavesBLoc = getIt<UserLeavesBloc>();
  final NavigationStackManager _stackManager = getIt<NavigationStackManager>();


  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return ElevatedButton(
      onPressed: () {
        _userLeavesBLoc.cancelLeave(leave: leave);
        showSnackBar(context,
            (leave.leaveStatus == pendingLeaveStatus)
                ? _localization.user_leave_detail_cancel_leave_message
                : _localization.user_leave_detail_delete_leave_message);
        _stackManager.pop();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: (leave.leaveStatus == pendingLeaveStatus)
            ? AppColors.greyColor
            : AppColors.redColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 45),
      ),
      child: Text(
          (leave.leaveStatus == pendingLeaveStatus)
              ? _localization.user_leave_detail_button_cancel
              : _localization.user_leave_detail_button_delete,
          style: AppTextStyle.subtitleText),
    );
  }
}
