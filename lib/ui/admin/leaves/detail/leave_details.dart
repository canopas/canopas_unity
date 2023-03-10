import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import 'package:projectunity/ui/admin/leaves/detail/widget/leave_action_button.dart';
import 'package:projectunity/ui/admin/leaves/detail/widget/leave_details_date_content.dart';
import 'package:projectunity/ui/admin/leaves/detail/widget/leave_details_header_content.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/space_constant.dart';
import '../../../../di/service_locator.dart';
import '../../../../model/leave_application.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/leave_details_widget/leave_details_per_day_duration_content.dart';
import '../../../../widget/leave_details_widget/reason_content.dart';
import '../../../../widget/leave_details_widget/user_content.dart';
import 'bloc/admin_leave_detail_bloc.dart';
import 'bloc/admin_leave_detail_event.dart';
import 'bloc/admin_leave_detail_state.dart';

class AdminLeaveDetailsPage extends StatelessWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveDetailsPage({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminLeaveDetailBloc>()
        ..add(FetchLeaveApplicationDetailEvent(
            employeeId: leaveApplication.leave.uid)),
      child: AdminLeaveDetailsScreen(leaveApplication: leaveApplication),
    );
  }
}

class AdminLeaveDetailsScreen extends StatefulWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveDetailsScreen({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  State<AdminLeaveDetailsScreen> createState() =>
      _AdminLeaveDetailsScreenState();
}

class _AdminLeaveDetailsScreenState extends State<AdminLeaveDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final rejectionReason = widget.leaveApplication.leave.rejectionReason ?? "";
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text(localization.details_tag),
        ),
        body: BlocConsumer<AdminLeaveDetailBloc, AdminLeaveDetailState>(
          listenWhen: (previous, current) =>
              current is DeleteLeaveApplicationSuccessState,
          listener: (context, state) {
            if (state is DeleteLeaveApplicationSuccessState) {
              context.goNamed(Routes.adminLeaves);
              showSnackBar(
                  context: context,
                  msg: localization.user_leave_detail_delete_leave_message);
            }
          },
          buildWhen: (previous, current) =>
              current is DeleteLeaveApplicationLoadingState,
          builder: (context, state) {
            if (state is DeleteLeaveApplicationLoadingState) {
              return const AppCircularProgressIndicator();
            }
            return ListView(
              padding:
                  const EdgeInsets.only(bottom: 100, top: primaryHalfSpacing),
              children: [
                LeaveTypeAgoTitleWithStatus(
                    status: widget.leaveApplication.leave.leaveStatus,
                    appliedOnInTimeStamp:
                        widget.leaveApplication.leave.appliedOn,
                    leaveType: widget.leaveApplication.leave.leaveType),
                UserContent(employee: widget.leaveApplication.employee),
                LeaveDetailsDateContent(leave: widget.leaveApplication.leave),
                PerDayDurationDateRange(
                    perDayDurationWithDate:
                        widget.leaveApplication.leave.getDateAndDuration()),
                ReasonField(
                  title: localization.reason_tag,
                  reason: widget.leaveApplication.leave.reason,
                ),
                ReasonField(
                    reason: rejectionReason,
                    title: localization.admin_leave_detail_note_tag,
                    hide: rejectionReason.isEmpty)
              ],
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: widget.leaveApplication.leave.startDate.toDate
                .isBefore(DateTime.now())
            ? null
            : LeaveDetailActionButton(
                leaveStatus: widget.leaveApplication.leave.leaveStatus,
                onTap: () => context.read<AdminLeaveDetailBloc>().add(
                    DeleteLeaveApplicationEvent(
                        widget.leaveApplication.leave.leaveId)),
              ));
  }
}
