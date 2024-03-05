import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/ui/admin/leaves/details/widget/admin_leave_details_action_button.dart';
import 'package:projectunity/ui/admin/leaves/details/widget/admin_leave_details_date_content.dart';
import 'package:projectunity/ui/admin/leaves/details/widget/admin_leave_details_response_text_field.dart';
import 'package:projectunity/ui/admin/leaves/details/widget/admin_leave_details_used_leave_count_view.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/model/employee/employee.dart';
import '../../../../data/model/leave/leave.dart';
import '../../../../data/model/leave_application.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_details_widget/leave_details_header_content.dart';
import '../../../widget/leave_details_widget/leave_details_per_day_duration_content.dart';
import '../../../widget/leave_details_widget/reason_content.dart';
import '../../../widget/leave_details_widget/user_content.dart';
import 'bloc/admin_leave_details_bloc.dart';
import 'bloc/admin_leave_details_event.dart';
import 'bloc/admin_leave_details_state.dart';

class AdminLeaveDetailsPage extends StatelessWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveDetailsPage({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminLeaveDetailsBloc>()
        ..add(AdminLeaveDetailsFetchLeaveCountEvent(
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
    return AppPage(
      backGroundColor: context.colorScheme.surface,
      title: AppLocalizations.of(context).details_tag,
      body: BlocListener<AdminLeaveDetailsBloc, AdminLeaveDetailsState>(
        listenWhen: (previous, current) =>
            current.leaveCountStatus == Status.error ||
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          if (state.leaveCountStatus == Status.error ||
              state.actionStatus == Status.error) {
            showSnackBar(context: context, error: state.error);
          } else if (state.actionStatus == Status.success) {
            context.pop(widget.leaveApplication.leave.leaveId);
          }
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100, top: primaryHalfSpacing),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserContent(employee: widget.leaveApplication.employee),
                  const LeaveCountsView(),
                  const Divider(),
                  LeaveTypeAgoTitleWithStatus(
                      status: widget.leaveApplication.leave.status,
                      appliedOn: widget.leaveApplication.leave.appliedOn,
                      leaveType: widget.leaveApplication.leave.type),
                  AdminLeaveRequestDetailsDateContent(
                      leave: widget.leaveApplication.leave),
                ],
              ),
            ),
            PerDayDurationDateRange(
                perDayDurationWithDate:
                    widget.leaveApplication.leave.getDateAndDuration()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValidateWidget(
                    isValid: widget.leaveApplication.leave.reason.isNotEmpty,
                    child: ReasonField(
                      title: localization.reason_tag,
                      reason: widget.leaveApplication.leave.reason,
                    ),
                  ),
                  ValidateWidget(
                    isValid: (widget.leaveApplication.leave.response ?? "")
                        .isNotEmpty,
                    child: ReasonField(
                      reason: (widget.leaveApplication.leave.response ?? ""),
                      title: localization.admin_leave_detail_note_tag,
                    ),
                  ),
                  ValidateWidget(
                      isValid: !(getIt<UserStateNotifier>().isHR &&
                              widget.leaveApplication.employee.role ==
                                  Role.hr) &&
                          widget.leaveApplication.leave.status ==
                              LeaveStatus.pending,
                      child: const ApproveRejectionMessage()),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AdminLeaveDetailsActionButton(
          leaveApplication: widget.leaveApplication,
        ),
      ),
    );
  }
}
