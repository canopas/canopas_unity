import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/date_formatter.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/user_content.dart';
import 'package:projectunity/widget/Leave_details_screen_widgets/leave_details_header_content.dart';
import 'package:projectunity/widget/Leave_details_screen_widgets/reason_content.dart';
import 'package:projectunity/widget/Leave_details_screen_widgets/remaining_leave_content.dart';
import '../../../../bloc/admin/leave_details/admin_leave_details_bloc.dart';
import '../../../../configs/colors.dart';
import '../../../../core/utils/const/other_constant.dart';
import '../../../../model/leave/leave.dart';

class AdminLeaveRequestDetailScreen extends StatefulWidget {
  final LeaveApplication employeeLeave;

  const AdminLeaveRequestDetailScreen({Key? key, required this.employeeLeave})
      : super(key: key);

  @override
  State<AdminLeaveRequestDetailScreen> createState() =>
      _AdminLeaveRequestDetailScreenState();
}

class _AdminLeaveRequestDetailScreenState
    extends State<AdminLeaveRequestDetailScreen> {
  final TextEditingController _approvalOrRejectionMassage =
      TextEditingController();

  final _adminDetailsScreenBloc = getIt<AdminLeaveDetailsScreenBloc>();

  @override
  void initState() {
    _adminDetailsScreenBloc.fetchUserRemainingLeaveDetails(id: widget.employeeLeave.employee.id);
    super.initState();
  }

  @override
  void dispose() {
    _adminDetailsScreenBloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String appliedTime = DateFormatter(AppLocalizations.of(context))
        .timeAgoPresentation(widget.employeeLeave.leave.appliedOn);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).leave_detail_title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 100),
        children: [
          LeaveTypeAgoTitle(
              timeAgo: appliedTime,
              leaveType: widget.employeeLeave.leave.leaveType),
          UserContent(employee: widget.employeeLeave.employee!),
          RemainingLeaveContainer(
             remainingLeaveStream: _adminDetailsScreenBloc.remainingLeaveStream,
              leave: widget.employeeLeave.leave),
          ReasonField(
            reason: widget.employeeLeave.leave.reason,
          ),
          (widget.employeeLeave.leave.leaveStatus != approveLeaveStatus)
              ? _approvalRejectionMessage(context: context)
              : Container(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
      (widget.employeeLeave.leave.leaveStatus != approveLeaveStatus)
          ? _buildButton(context, _approvalOrRejectionMassage.text,
          widget.employeeLeave.leave.leaveId)
          : null,
    );
  }

  _buildButton(BuildContext context, String reason, String leaveId) {
    final _localization = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 45),
              backgroundColor: AppColors.redColor,
            ),
            onPressed: () {
              _adminDetailsScreenBloc.rejectOrApproveLeaveRequest(reason: reason, leaveId: leaveId,leaveStatus: rejectLeaveStatus);
            },
            child: Text(
              _localization.admin_leave_detail_button_reject,
              style: AppTextStyle.subtitleText,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 45),
              backgroundColor: AppColors.greenColor,
            ),
            onPressed: () {
              _adminDetailsScreenBloc.rejectOrApproveLeaveRequest(reason: reason, leaveId: leaveId,leaveStatus: approveLeaveStatus);
            },
            child: Text(
              _localization.admin_leave_detail_button_approve,
              style: AppTextStyle.subtitleText,
            ),
          ),
        ],
      ),
    );
  }

  _approvalRejectionMessage({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).admin_leave_detail_message_title_text,
            style: AppTextStyle.secondarySubtitle500,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _approvalOrRejectionMassage,
            maxLines: 5,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText:
                  AppLocalizations.of(context).admin_leave_detail_error_reason,
              filled: true,
              fillColor: AppColors.primaryBlue.withOpacity(0.10),
            ),
          ),
        ],
      ),
    );
  }
}
