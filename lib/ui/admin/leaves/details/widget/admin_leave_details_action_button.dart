import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/other/app_button.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/di/service_locator.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/provider/user_state.dart';
import '../../../../widget/app_dialog.dart';
import '../bloc/admin_leave_details_bloc.dart';
import '../bloc/admin_leave_details_event.dart';
import '../bloc/admin_leave_details_state.dart';

class AdminLeaveDetailsActionButton extends StatelessWidget {
  final LeaveApplication leaveApplication;

  const AdminLeaveDetailsActionButton({
    Key? key,
    required this.leaveApplication,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userStateNotifier = getIt<UserStateNotifier>();
    if ((leaveApplication.leave.status == LeaveStatus.approved &&
            !(userStateNotifier.isHR &&
                leaveApplication.employee.role == Role.hr)) ||
        (leaveApplication.leave.uid == userStateNotifier.employeeId &&
            leaveApplication.leave.status == LeaveStatus.pending)) {
      return BlocBuilder<AdminLeaveDetailsBloc, AdminLeaveDetailsState>(
          buildWhen: (previous, current) =>
              previous.actionStatus != current.actionStatus,
          builder: (context, state) => AppButton(
                onTap: () async => _showAlertDialogue(context),
                tag: context.l10n.cancel_button_tag,
                loading: state.actionStatus == Status.loading,
              ));
    }
    if (leaveApplication.leave.status == LeaveStatus.pending &&
        !(userStateNotifier.isHR &&
            leaveApplication.employee.role == Role.hr)) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(50),
          boxShadow: AppTheme.commonBoxShadow(context),
        ),
        child: BlocBuilder<AdminLeaveDetailsBloc, AdminLeaveDetailsState>(
          buildWhen: (previous, current) =>
              previous.actionStatus != current.actionStatus,
          builder: (context, state) => state.actionStatus == Status.loading
              ? const AppCircularProgressIndicator(size: 25)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.3, 45),
                        backgroundColor: context.colorScheme.rejectColor,
                      ),
                      onPressed: () {
                        context
                            .read<AdminLeaveDetailsBloc>()
                            .add(LeaveResponseEvent(
                              endDate: leaveApplication.leave.endDate,
                              startDate: leaveApplication.leave.startDate,
                              email: leaveApplication.employee.email,
                              name: leaveApplication.employee.name,
                              responseStatus: LeaveStatus.rejected,
                              leaveId: leaveApplication.leave.leaveId,
                            ));
                      },
                      child: Text(
                          context.l10n.admin_leave_detail_reject_button_tag,
                          style: AppTextStyle.style16.copyWith(
                              color: context.colorScheme.textPrimary)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.3, 45),
                        backgroundColor: context.colorScheme.approveColor,
                      ),
                      onPressed: () {
                        context.read<AdminLeaveDetailsBloc>().add(
                            LeaveResponseEvent(
                                endDate: leaveApplication.leave.endDate,
                                startDate: leaveApplication.leave.startDate,
                                email: leaveApplication.employee.email,
                                name: leaveApplication.employee.name,
                                responseStatus: LeaveStatus.approved,
                                leaveId: leaveApplication.leave.leaveId));
                      },
                      child: Text(
                          context.l10n.admin_leave_detail_approve_button_tag,
                          style: AppTextStyle.style16.copyWith(
                              color: context.colorScheme.textPrimary)),
                    ),
                  ],
                ),
        ),
      );
    }
    return const SizedBox();
  }

  void _showAlertDialogue(BuildContext context) async {
    await showAppAlertDialog(
        context: context,
        title: context.l10n.cancel_button_tag,
        actionButtonTitle: context.l10n.ok_tag,
        description: context.l10n.remove_user_leave_alert,
        onActionButtonPressed: () {
          context.read<AdminLeaveDetailsBloc>().add(LeaveResponseEvent(
                endDate: leaveApplication.leave.endDate,
                startDate: leaveApplication.leave.startDate,
                email: leaveApplication.employee.email,
                name: leaveApplication.employee.name,
                responseStatus: LeaveStatus.cancelled,
                leaveId: leaveApplication.leave.leaveId,
              ));
        });
  }
}
