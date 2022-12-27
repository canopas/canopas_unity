import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import 'package:projectunity/ui/admin/leave_details/widget/admin_leave_detail_approve_rejection_message.dart';

import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import '../../../router/app_router.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_details_widget/leave_details_header_content.dart';
import '../../../widget/leave_details_widget/leave_details_per_day_duration_content.dart';
import '../../../widget/leave_details_widget/reason_content.dart';
import '../../../widget/leave_details_widget/user_content.dart';
import 'bloc/admin_leave_details_bloc.dart';
import 'bloc/admin_leave_details_event.dart';
import 'bloc/admin_leave_details_state.dart';
import 'widget/admin_leave_details_action_button.dart';
import 'widget/admin_leave_details_date_content.dart';

class AdminLeaveDetailsPage extends StatelessWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveDetailsPage({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminLeaveDetailsBloc>()
        ..add(AdminLeaveDetailsInitialLoadEvents(
            leaveApplication: leaveApplication)),
      child: AdminLeaveDetailsView(leaveApplication: leaveApplication),
    );
  }
}



class AdminLeaveDetailsView extends StatefulWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveDetailsView({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  State<AdminLeaveDetailsView> createState() => _AdminLeaveDetailsViewState();
}

class _AdminLeaveDetailsViewState extends State<AdminLeaveDetailsView> {

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
      body: BlocListener<AdminLeaveDetailsBloc,AdminLeaveDetailsState>(
        listenWhen: (previous, current) => current.isFailure,
        listener: (context, state) {
          if (state.isFailure) {
            showSnackBar(context: context, error: state.error);
          }
          if (state.leaveDetailsStatus == AdminLeaveDetailsStatus.success) {
            context.pop();
          }
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100,top: primaryHalfSpacing),
          children: [
            LeaveTypeAgoTitleWithStatus(
                hideLeaveStatus: widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus,
                status: widget.leaveApplication.leave.leaveStatus,
                appliedOnInTimeStamp: widget.leaveApplication.leave.appliedOn,
                leaveType: widget.leaveApplication.leave.leaveType
            ),
            UserContent(
                employee: widget.leaveApplication.employee,
            ),
            AdminLeaveDetailsDateContent(leave: widget.leaveApplication.leave),
            PerDayDurationDateRange(perDayDurationWithDate: widget.leaveApplication.leave.getDateAndDuration()),
            ReasonField(
              title: localization.leave_reason_tag,
              reason: widget.leaveApplication.leave.reason,
            ),
            ApproveRejectionMessage(leaveStatus: widget.leaveApplication.leave.leaveStatus),
            ReasonField(
              reason: rejectionReason,
              title: localization.admin_leave_detail_message_title_text,
              hide: rejectionReason.isEmpty || widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.leaveApplication.leave.leaveStatus == pendingLeaveStatus
          ?AdminLeaveDetailsActionButton(leaveID: widget.leaveApplication.leave.leaveId,):null,
    );
  }
}


