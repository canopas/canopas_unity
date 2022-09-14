import 'package:flutter/material.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/leave_details_header_content.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/reason_content.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/remaining_leave_content.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/user_content.dart';
import '../../../../configs/colors.dart';
import '../../../../core/utils/const/other_constant.dart';
import '../../../../model/leave/leave.dart';
import 'widget/button_content.dart';

class AdminLeaveRequestDetailScreen extends StatefulWidget {
  final LeaveApplication employeeLeave;

   const AdminLeaveRequestDetailScreen({Key? key, required this.employeeLeave})
      : super(key: key);

  @override
  State<AdminLeaveRequestDetailScreen> createState() => _AdminLeaveRequestDetailScreenState();
}

class _AdminLeaveRequestDetailScreenState extends State<AdminLeaveRequestDetailScreen> {
  final TextEditingController _approvalOrRejectionMassage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).leave_detail_title),
      ),
      body: ListView(
        children: [
          LeaveTypeAgoTitle(timeAgo: widget.employeeLeave.leave.appliedOn.toDate.timeAgo(),leaveType: widget.employeeLeave.leave.leaveType),
           UserContent(employee: widget.employeeLeave.employee),
          RemainingLeaveContainer(employeeLeave: widget.employeeLeave),
          ReasonField(reason: widget.employeeLeave.leave.reason,),
          (widget.employeeLeave.leave.leaveStatus != approveLeaveStatus)?_approvalRejectionMessage(context: context):Container(),
          (widget.employeeLeave.leave.leaveStatus != approveLeaveStatus)?ButtonContent(
            leaveId: widget.employeeLeave.leave.leaveId,
            reason: _approvalOrRejectionMassage.text,
          ):Container(),
        ],
      ),
    );
  }
  _approvalRejectionMessage({required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.all(primaryHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).admin_leave_detail_message_title_text, style: AppTextStyle.secondarySubtitle500,),
          const SizedBox(height: 10,),
          TextField(
            controller: _approvalOrRejectionMassage,
            maxLines: 5,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText: AppLocalizations.of(context).admin_leave_detail_error_reason,
              filled: true,
              fillColor: AppColors.primaryBlue.withOpacity(0.10),
            ),
          ),
        ],
      ),
    );
  }
}