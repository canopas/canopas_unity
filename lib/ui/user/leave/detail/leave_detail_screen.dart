import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/bloc/employee/leave_details/employee_leave_details_bloc.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/core/utils/date_formatter.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/ui/user/leave/detail/widget/aprroval_status_tag.dart';
import 'package:projectunity/ui/user/leave/detail/widget/leave_action_button.dart';

import '../../../../configs/colors.dart';
import '../../../../widget/Leave_details_screen_widgets/leave_details_header_content.dart';
import '../../../../widget/Leave_details_screen_widgets/reason_content.dart';
import '../../../../widget/Leave_details_screen_widgets/remaining_leave_content.dart';
import '../../../../widget/error_snackbar.dart';

class UserLeaveDetailScreen extends StatefulWidget {
  final Leave leave;
  const UserLeaveDetailScreen({Key? key, required this.leave}) : super(key: key);

  @override
  State<UserLeaveDetailScreen> createState() => _UserLeaveDetailScreenState();
}

class _UserLeaveDetailScreenState extends State<UserLeaveDetailScreen> {

  final EmployeeLeaveDetailsBloc _employeeLeaveDetailsBloc = getIt<EmployeeLeaveDetailsBloc>();

  @override
  void initState() {
    _employeeLeaveDetailsBloc.attach();
    super.initState();
  }

  @override
  void dispose() {
    _employeeLeaveDetailsBloc.detach();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    String appliedTime =
        DateFormatter(localization).timeAgoPresentation(widget.leave.appliedOn);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text(
            localization.leave_detail_title,
            style: AppTextStyle.appBarTitle,
          ),
        ),
        body: ListView(
          children: [
            LeaveTypeAgoTitle(
                appliedOn: appliedTime, leaveType: widget.leave.leaveType),
            const SizedBox(
              height: primaryHorizontalSpacing,
            ),
            RemainingLeaveContainer(
              leave: widget.leave,
              remainingLeaveStream:
                  _employeeLeaveDetailsBloc.remainingLeaveStream,
            ),
            ReasonField(
              reason: widget.leave.reason,
            ),
            ApprovalStatusTag(
                leaveStatus: widget.leave.leaveStatus,
                rejectionReason: widget.leave.rejectionReason),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (widget.leave.leaveStatus != approveLeaveStatus ||
                widget.leave.startDate > DateTime.now().timeStampToInt)
            ? LeaveActionButton(leaveStatus: widget.leave.leaveStatus, onPressed: (){
          _employeeLeaveDetailsBloc.removeLeaveRequest(
                      leave: widget.leave);
                  showSnackBar(
                      context: context,
                      msg: (widget.leave.leaveStatus == pendingLeaveStatus)
                          ? localization.user_leave_detail_cancel_leave_message
                          : localization
                              .user_leave_detail_delete_leave_message);
                },)
            : null);
  }
}


