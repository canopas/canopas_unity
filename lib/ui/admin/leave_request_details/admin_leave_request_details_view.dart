import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import 'package:projectunity/ui/admin/leave_request_details/widget/admin_leave_request_detail_approve_rejection_message.dart';
import 'package:projectunity/ui/admin/leave_request_details/widget/admin_request_details_header.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import '../../../model/leave_application.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_details_widget/leave_details_per_day_duration_content.dart';
import '../../../widget/leave_details_widget/reason_content.dart';
import '../../../widget/leave_details_widget/user_content.dart';
import 'bloc/admin_leave_details_bloc.dart';
import 'bloc/admin_leave_details_event.dart';
import 'bloc/admin_leave_details_state.dart';
import 'widget/admin_leave_request_details_action_button.dart';
import 'widget/admin_leave_request_details_date_content.dart';

class AdminLeaveRequestDetailsPage extends StatelessWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveRequestDetailsPage({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminLeaveApplicationDetailsBloc>()
        ..add(AdminLeaveRequestDetailsInitialLoadEvents(
            leaveApplication: leaveApplication)),
      child: AdminLeaveRequestDetailsView(leaveApplication: leaveApplication),
    );
  }
}



class AdminLeaveRequestDetailsView extends StatefulWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveRequestDetailsView({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  State<AdminLeaveRequestDetailsView> createState() => _AdminLeaveRequestDetailsViewState();
}

class _AdminLeaveRequestDetailsViewState extends State<AdminLeaveRequestDetailsView> {

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).leave_detail_title),
      ),
      body: BlocListener<AdminLeaveApplicationDetailsBloc,AdminLeaveApplicationDetailsState>(
        listenWhen: (previous, current) => current.isFailure,
        listener: (context, state) {
          if (state.isFailure) {
            showSnackBar(context: context, error: state.error);
          }
          if (state.leaveDetailsStatus == AdminLeaveApplicationDetailsStatus.success) {
            context.pop();
          }
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100,top: primaryHalfSpacing),
          children: [
            AdminLeaveRequestLeaveTypeHeader(
                appliedOnInTimeStamp: widget.leaveApplication.leave.appliedOn,
                leaveType: widget.leaveApplication.leave.leaveType
            ),
            UserContent(employee: widget.leaveApplication.employee,),
            AdminLeaveRequestDetailsDateContent(leave: widget.leaveApplication.leave),
            PerDayDurationDateRange(perDayDurationWithDate: widget.leaveApplication.leave.getDateAndDuration()),
            ReasonField(
              title: localization.leave_reason_tag,
              reason: widget.leaveApplication.leave.reason,
            ),
            const ApproveRejectionMessage(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AdminLeaveDetailsActionButton(leaveID: widget.leaveApplication.leave.leaveId,),
    );
  }
}


