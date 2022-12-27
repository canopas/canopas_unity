import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import 'package:projectunity/ui/user/leave_details/widget/employee_leave_action_button.dart';
import 'package:projectunity/ui/user/leave_details/widget/employee_leave_details_date_content.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../widget/leave_details_widget/leave_details_per_day_duration_content.dart';
import '../../../widget/leave_details_widget/reason_content.dart';
import '../../../widget/leave_details_widget/leave_details_header_content.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_details_widget/user_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/leave_details_bloc/employee_leave_details_bloc.dart';
import 'bloc/leave_details_bloc/leave_details_event.dart';
import 'bloc/leave_details_bloc/leave_details_state.dart';

class EmployeeLeaveDetailsPage extends StatelessWidget {
  final LeaveApplication leaveApplication;
  const EmployeeLeaveDetailsPage({Key? key, required this.leaveApplication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployeeLeaveDetailsBloc>()..add(EmployeeLeaveDetailsInitialLoadEvents(leaveApplication: leaveApplication)),
      child: EmployeeLeaveDetailsView(leaveApplication: leaveApplication),
      );
  }
}



class EmployeeLeaveDetailsView extends StatefulWidget {
  final LeaveApplication leaveApplication;

  const EmployeeLeaveDetailsView({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  State<EmployeeLeaveDetailsView> createState() => _EmployeeLeaveDetailsViewState();
}

class _EmployeeLeaveDetailsViewState extends State<EmployeeLeaveDetailsView> {

  @override
  Widget build(BuildContext context) {
    final showButton = (widget.leaveApplication.leave.leaveStatus != approveLeaveStatus || widget.leaveApplication.leave.startDate > DateTime.now().timeStampToInt)
        && context.read<EmployeeLeaveDetailsBloc>().currentUserId == widget.leaveApplication.leave.uid;
    final localization = AppLocalizations.of(context);
    final rejectionReason = widget.leaveApplication.leave.rejectionReason ?? "";

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).leave_detail_title),
      ),
      body: BlocListener<EmployeeLeaveDetailsBloc,EmployeeLeaveDetailsState>(
        listener: (context, state) {
          if(state.leaveDetailsStatus == EmployeeLeaveDetailsStatus.success){
            showSnackBar(
                context: context,
                msg: (widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus)
                    ? AppLocalizations.of(context).user_leave_detail_cancel_leave_message
                    : AppLocalizations.of(context).user_leave_detail_delete_leave_message);
            context.pop();
          } else if(state.isFailure){
            showSnackBar(context: context,error: state.error);
          }
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100,top: primaryHalfSpacing),
          children: [
            LeaveTypeAgoTitleWithStatus(
                status: widget.leaveApplication.leave.leaveStatus,
                appliedOnInTimeStamp: widget.leaveApplication.leave.appliedOn,
                leaveType: widget.leaveApplication.leave.leaveType),
            context.read<EmployeeLeaveDetailsBloc>().currentUserId != widget.leaveApplication.employee.id
                ?UserContent(employee: widget.leaveApplication.employee,)
                :const SizedBox(),
            EmployeeLeaveDetailsDateContent(leave: widget.leaveApplication.leave),
            PerDayDurationDateRange(perDayDurationWithDate: widget.leaveApplication.leave.getDateAndDuration()),
            ReasonField(
              hide: context.read<EmployeeLeaveDetailsBloc>().currentUserId != widget.leaveApplication.leave.uid,
              title: localization.leave_reason_tag,
              reason: widget.leaveApplication.leave.reason,
            ),
            ReasonField(
                reason: rejectionReason,
                title: localization.admin_leave_detail_message_title_text,
                hide: rejectionReason.isEmpty || widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus ||
                    rejectionReason.isNotEmpty && context.read<EmployeeLeaveDetailsBloc>().currentUserId != widget.leaveApplication.leave.uid,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: showButton?EmployeeLeaveDetailActionButton(leaveStatus: widget.leaveApplication.leave.leaveStatus, onPressed: (){
        context.read<EmployeeLeaveDetailsBloc>().add(EmployeeLeaveDetailsRemoveLeaveRequestEvent(widget.leaveApplication));
      },):null,
    );
  }
}






