import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/bloc/shared/leave_details/leave_details_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/ui/shared/leave_detail/widget/leave_action_button.dart';
import '../../../configs/colors.dart';
import '../../../configs/text_style.dart';
import '../../../configs/theme.dart';
import '../../../core/utils/const/leave_time_constants.dart';
import '../../../core/utils/const/space_constant.dart';
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
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final rejectionReason = widget.leaveApplication.leave.rejectionReason ?? "";

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).leave_detail_title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 100,top: primaryHalfSpacing),
        children: [
          LeaveTypeAgoTitleWithStatus(
              hideLeaveStatus: widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus && _leaveDetailBloc.currentUserIsAdmin,
              status: widget.leaveApplication.leave.leaveStatus,
              appliedOnInTimeStamp: widget.leaveApplication.leave.appliedOn,
              leaveType: widget.leaveApplication.leave.leaveType),
          (_leaveDetailBloc.currentUserId != widget.leaveApplication.employee.id)
              ?UserContent(
              employee: widget.leaveApplication.employee,
              onTap: _leaveDetailBloc.currentUserIsAdmin?(){
                _leaveDetailBloc.onUserContentTap(id: widget.leaveApplication.employee.id);
              }:null
          )
              :const SizedBox(),
          RemainingLeaveContainer(
             leaveCounts: widget.leaveApplication.leaveCounts ?? LeaveCounts(),
              leave: widget.leaveApplication.leave),
          PerDayDurationDateRange(perDayDurationWithDate: widget.leaveApplication.leave.getDateAndDuration()),
          ReasonField(
            hide: _leaveDetailBloc.currentUserId != widget.leaveApplication.leave.uid && !_leaveDetailBloc.currentUserIsAdmin,
            title: localization.leave_reason_tag,
            reason: widget.leaveApplication.leave.reason,
          ),
           _approvalRejectionMessage(context: context),
          ReasonField(
              reason: rejectionReason,
              title: localization.admin_leave_detail_message_title_text,
              hide: rejectionReason.isEmpty || widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus ||
                  (rejectionReason.isNotEmpty && _leaveDetailBloc.currentUserId != widget.leaveApplication.leave.uid && !_leaveDetailBloc.currentUserIsAdmin),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: leaveActionButton(),
    );
  }

  Widget _approvalRejectionMessage({required BuildContext context}) {
    return (widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus && _leaveDetailBloc.currentUserIsAdmin)?Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing,vertical: primaryHalfSpacing),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing).copyWith(bottom: 4),
            decoration: BoxDecoration(
              boxShadow: AppTheme.commonBoxShadow,
              borderRadius: AppTheme.commonBorderRadius,
              color: AppColors.whiteColor,
            ),
            child: TextField(
              style: AppTextStyle.bodyTextDark,
              controller: _approvalOrRejectionMassage,
              maxLines: 5,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                AppLocalizations.of(context).admin_leave_detail_error_reason,
              ),
            ),
          ),
        ],
      ),
    ):const SizedBox();
  }

  Widget? leaveActionButton(){
    if(widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus && _leaveDetailBloc.currentUserIsAdmin){
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




class PerDayDurationDateRange extends StatelessWidget {
  final Map<DateTime,int> perDayDurationWithDate;
  const PerDayDurationDateRange({Key? key, required this.perDayDurationWithDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    perDayDurationWithDate.removeWhere((key, value) => key.isWeekend);
    final localization = AppLocalizations.of(context);
    return perDayDurationWithDate.length>2?SingleChildScrollView(
      padding: const EdgeInsets.all(primaryVerticalSpacing),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: perDayDurationWithDate.entries.map((date) =>  Container(
          padding: const EdgeInsets.all(primaryHalfSpacing),
          margin: const EdgeInsets.symmetric(horizontal: primaryVerticalSpacing),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: AppTheme.commonBoxShadow,
            borderRadius: AppTheme.commonBorderRadius,
          ),
          child: Column(
            children: [
              Text(DateFormat('EEE',localization.localeName).format(date.key),),
              Text(DateFormat('d',localization.localeName).format(date.key),style: AppTextStyle.titleText.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),),
              Text(DateFormat('MMM',localization.localeName).format(date.key),),
              const SizedBox(height: primaryVerticalSpacing,),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.width*0.12,
                width: MediaQuery.of(context).size.width*0.26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryGray),
                ),
                child: Text(dayLeaveTime[date.value].toString()),
              ),
            ],
          ),
        )).toList(),
      ),
    ):Column(
        children: perDayDurationWithDate.entries.map((date) => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(primaryHalfSpacing),
            margin: const EdgeInsets.symmetric(vertical: primaryHalfSpacing,horizontal: primarySpacing),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: AppTheme.commonBoxShadow,
              borderRadius: AppTheme.commonBorderRadius,
            ),
            child: Row(
              children: [
                Text(DateFormat('EEEE, ',localization.localeName).format(date.key),style: AppTextStyle.bodyTextDark,),
                Text(DateFormat('d ',localization.localeName).format(date.key),style: AppTextStyle.bodyTextDark.copyWith(color: AppColors.primaryBlue,fontWeight: FontWeight.bold),),
                Text(DateFormat('MMMM',localization.localeName).format(date.key),style: AppTextStyle.bodyTextDark,),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width*0.12,
                  width: MediaQuery.of(context).size.width*0.26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primaryGray),
                  ),
                  child: Text(dayLeaveTime[date.value].toString()),
                )
              ],
            )

        ) ).toList()
    );
  }
}


