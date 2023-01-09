import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import 'package:projectunity/ui/shared/leave_details/widget/leave_action_button.dart';
import 'package:projectunity/ui/shared/leave_details/widget/leave_details_date_content.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../widget/leave_details_widget/leave_details_per_day_duration_content.dart';
import '../../../widget/leave_details_widget/reason_content.dart';
import 'widget/leave_details_header_content.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_details_widget/user_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/leave_details_bloc/employee_leave_details_bloc.dart';
import 'bloc/leave_details_bloc/leave_details_event.dart';
import 'bloc/leave_details_bloc/leave_details_state.dart';

class LeaveDetailsPage extends StatelessWidget {
  final LeaveApplication leaveApplication;
  const LeaveDetailsPage({Key? key, required this.leaveApplication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LeaveDetailsBloc>()..add(LeaveDetailsInitialLoadEvents(leaveApplication: leaveApplication)),
      child: LeaveDetailsView(leaveApplication: leaveApplication),
      );
  }
}



class LeaveDetailsView extends StatefulWidget {
  final LeaveApplication leaveApplication;

  const LeaveDetailsView({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  State<LeaveDetailsView> createState() => _LeaveDetailsViewState();
}

class _LeaveDetailsViewState extends State<LeaveDetailsView> {

  @override
  Widget build(BuildContext context) {
    final userAreNotSame = context.read<LeaveDetailsBloc>().currentUserId != widget.leaveApplication.leave.uid;
    final currentUserIsNotAdmin = !context.read<LeaveDetailsBloc>().currentUserIsAdmin;

    final showButton = (widget.leaveApplication.leave.leaveStatus != approveLeaveStatus || widget.leaveApplication.leave.startDate > DateTime.now().timeStampToInt)
        && (context.read<LeaveDetailsBloc>().currentUserId == widget.leaveApplication.leave.uid || context.read<LeaveDetailsBloc>().currentUserIsAdmin);

    final localization = AppLocalizations.of(context);
    final rejectionReason = widget.leaveApplication.leave.rejectionReason ?? "";

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(localization.leave_detail_title),
      ),
      body: BlocListener<LeaveDetailsBloc,LeaveDetailsState>(
        listener: (context, state) {
          if(state.leaveDetailsStatus == LeaveDetailsStatus.success){
            showSnackBar(
                context: context,
                msg: (widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus)
                    ?localization.user_leave_detail_cancel_leave_message
                    :localization.user_leave_detail_delete_leave_message);
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
            userAreNotSame?UserContent(employee: widget.leaveApplication.employee):const SizedBox(),
            LeaveDetailsDateContent(leave: widget.leaveApplication.leave),
            PerDayDurationDateRange(perDayDurationWithDate: widget.leaveApplication.leave.getDateAndDuration()),
            ReasonField(
              hide: userAreNotSame && currentUserIsNotAdmin,
              title: localization.leave_reason_tag,
              reason: widget.leaveApplication.leave.reason,
            ),
            ReasonField(
                reason: rejectionReason,
                title: localization.admin_leave_detail_message_title_text,
                hide: rejectionReason.isEmpty || widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus ||
                    rejectionReason.isNotEmpty && userAreNotSame && currentUserIsNotAdmin,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: showButton?LeaveDetailActionButton(leaveApplication: widget.leaveApplication):null,
    );
  }
}






