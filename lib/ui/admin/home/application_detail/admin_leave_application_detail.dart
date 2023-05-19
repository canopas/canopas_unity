import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/ui/admin/home/application_detail/widget/admin_leave_request_detail_approve_rejection_message.dart';
import 'package:projectunity/ui/admin/home/application_detail/widget/admin_leave_request_details_action_button.dart';
import 'package:projectunity/ui/admin/home/application_detail/widget/admin_leave_request_details_date_content.dart';
import 'package:projectunity/ui/admin/home/application_detail/widget/admin_request_details_header.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/model/employee/employee.dart';
import '../../../../data/model/leave_application.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_details_widget/leave_details_per_day_duration_content.dart';
import '../../../widget/leave_details_widget/reason_content.dart';
import '../../../widget/leave_details_widget/user_content.dart';
import 'bloc/admin_leave_application_detail_bloc.dart';
import 'bloc/admin_leave_application_detail_event.dart';
import 'bloc/admin_leave_application_detail_state.dart';

class AdminLeaveApplicationDetailsPage extends StatelessWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveApplicationDetailsPage(
      {Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminLeaveApplicationDetailsBloc>()
        ..add(AdminLeaveApplicationFetchLeaveCountEvent(
            employeeId: leaveApplication.employee.uid)),
      child:
          AdminLeaveApplicationDetailScreen(leaveApplication: leaveApplication),
    );
  }
}

class AdminLeaveApplicationDetailScreen extends StatefulWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveApplicationDetailScreen(
      {Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  State<AdminLeaveApplicationDetailScreen> createState() =>
      _AdminLeaveApplicationDetailScreenState();
}

class _AdminLeaveApplicationDetailScreenState
    extends State<AdminLeaveApplicationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).details_tag,
          style: AppFontStyle.appbarHeaderDark,
        ),
      ),
      body: BlocConsumer<AdminLeaveApplicationDetailsBloc,
          AdminLeaveApplicationDetailsState>(
        listenWhen: (previous, current) =>
            current.adminLeaveCountStatus == Status.error,
        listener: (context, state) {
          if (state.adminLeaveCountStatus == Status.error) {
            showSnackBar(context: context, error: state.error);
          }
          if (state.status == Status.success) {
            context.pop();
          }
        },
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const AppCircularProgressIndicator();
          }
          return ListView(
            padding:
                const EdgeInsets.only(bottom: 100, top: primaryHalfSpacing),
            children: [
              AdminLeaveRequestLeaveTypeHeader(
                  appliedOnInTimeStamp: widget.leaveApplication.leave.appliedOn,
                  leaveType: widget.leaveApplication.leave.type),
              UserContent(employee: widget.leaveApplication.employee),
              AdminLeaveRequestDetailsDateContent(
                  leave: widget.leaveApplication.leave),
              PerDayDurationDateRange(
                  perDayDurationWithDate:
                      widget.leaveApplication.leave.getDateAndDuration()),
              ValidateWidget(
                isValid: widget.leaveApplication.leave.reason.isNotEmpty,
                child: ReasonField(
                  title: localization.reason_tag,
                  reason: widget.leaveApplication.leave.reason,
                ),
              ),
              ValidateWidget(
                  isValid: !(getIt<UserManager>().isHR && widget.leaveApplication.employee.role == Role.hr),
                  child: const ApproveRejectionMessage()),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: getIt<UserManager>().isHR && widget.leaveApplication.employee.role == Role.hr
          ? null
          : AdminLeaveDetailsActionButton(
              leaveID: widget.leaveApplication.leave.leaveId),
    );
  }
}
