import 'package:flutter/material.dart';
import 'package:projectunity/bloc/shared/leave_details/leave_details_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/ui/shared/leave_detail/widget/aprroval_status_tag.dart';
import 'package:projectunity/ui/shared/leave_detail/widget/leave_action_button.dart';
import '../../../configs/colors.dart';
import '../../../configs/text_style.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../di/service_locator.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'widget/leave_details_header_content.dart';
import 'widget/reason_content.dart';
import 'widget/remaining_leave_content.dart';
import '../../../widget/error_snackbar.dart';
import 'widget/user_content.dart';


class LeaveDetailsView extends StatefulWidget {
  final LeaveApplication leaveApplication;

  const LeaveDetailsView({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  State<LeaveDetailsView> createState() => _LeaveDetailsViewState();
}

class _LeaveDetailsViewState extends State<LeaveDetailsView> {
  final TextEditingController _approvalOrRejectionMassage = TextEditingController();
  final _leaveDetailBloc = getIt<LeaveDetailBloc>();

  @override
  void initState() {
    _leaveDetailBloc.fetchUserRemainingLeaveDetails(id: widget.leaveApplication.employee.id);
    super.initState();
  }

  @override
  void dispose() {
    _leaveDetailBloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    String appliedTime = DateFormatter(localization)
        .timeAgoPresentation(widget.leaveApplication.leave.appliedOn);
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
              appliedOn: appliedTime,
              leaveType: widget.leaveApplication.leave.leaveType),
          (_leaveDetailBloc.currentUserId != widget.leaveApplication.employee.id)?UserContent(employee: widget.leaveApplication.employee):const SizedBox(),
          RemainingLeaveContainer(
              remainingLeaveStream: _leaveDetailBloc.remainingLeaveStream,
              leave: widget.leaveApplication.leave),
          (_leaveDetailBloc.currentUserId == widget.leaveApplication.leave.uid || _leaveDetailBloc.currentUserIsAdmin)?ReasonField(
            reason: widget.leaveApplication.leave.reason,
          ):const SizedBox(height: primaryHorizontalSpacing,),
          (widget.leaveApplication.leave.leaveStatus != pendingLeaveStatus && _leaveDetailBloc.currentUserIsAdmin)?ApprovalStatusTag(
              leaveStatus: widget.leaveApplication.leave.leaveStatus,
              rejectionReason: widget.leaveApplication.leave.rejectionReason):const SizedBox(),
          (widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus && _leaveDetailBloc.currentUserIsAdmin)
              ? _approvalRejectionMessage(context: context)
              : const SizedBox(),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: leaveActionButton(),
    );
  }

  Widget _approvalRejectionMessage({required BuildContext context}) {
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

  Widget? leaveActionButton(){
    if(widget.leaveApplication.leave.leaveStatus != approveLeaveStatus && _leaveDetailBloc.currentUserIsAdmin){
      return AdminLeaveDetailsActionButton(
          onApproveButtonPressed: (){
            _leaveDetailBloc.rejectOrApproveLeaveRequest(reason: _approvalOrRejectionMassage.text, leaveId: widget.leaveApplication.leave.leaveId,leaveStatus: approveLeaveStatus);
          },
          onRejectButtonPressed: (){
            _leaveDetailBloc.rejectOrApproveLeaveRequest(reason: _approvalOrRejectionMassage.text, leaveId: widget.leaveApplication.leave.leaveId,leaveStatus: rejectLeaveStatus);
          });
    }else if (widget.leaveApplication.leave.leaveStatus != approveLeaveStatus && !_leaveDetailBloc.currentUserIsAdmin ||
        widget.leaveApplication.leave.startDate > DateTime.now().timeStampToInt && !_leaveDetailBloc.currentUserIsAdmin ){
      return EmployeeLeaveDetailActionButton(leaveStatus: widget.leaveApplication.leave.leaveStatus, onPressed: (){
        _leaveDetailBloc.removeLeaveRequest(
            leave: widget.leaveApplication.leave);
        showSnackBar(
            context: context,
            msg: (widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus)
                ? AppLocalizations.of(context).user_leave_detail_cancel_leave_message
                : AppLocalizations.of(context).user_leave_detail_delete_leave_message);
      },);
    } else{
      return null;
    }
  }
}






