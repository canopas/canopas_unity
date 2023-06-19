import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
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
    final localization = AppLocalizations.of(context);
    if (leaveApplication.leave.status == LeaveStatus.approved &&
        !(getIt<UserStateNotifier>().isHR &&
            leaveApplication.employee.role == Role.hr)) {
      return CancelButton(onTap: () {
        showAlertDialog(
          context: context,
          title: AppLocalizations.of(context).cancel_button_tag,
          description: AppLocalizations.of(context).remove_user_leave_alert,
          actionButtonTitle: AppLocalizations.of(context).cancel_button_tag,
          onActionButtonPressed: () {
            context.read<AdminLeaveDetailsBloc>().add(LeaveResponseEvent(
                  endDate: leaveApplication.leave.endDate,
                  startDate: leaveApplication.leave.startDate,
                  email: leaveApplication.employee.email,
                  name: leaveApplication.employee.name,
                  responseStatus: LeaveStatus.cancelled,
                  leaveId: leaveApplication.leave.leaveId,
                ));
            context.pop();
          },
        );
      });
    }
    if (leaveApplication.leave.status == LeaveStatus.pending &&
        !(getIt<UserStateNotifier>().isHR &&
            leaveApplication.employee.role == Role.hr)) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: AppTheme.commonBoxShadow,
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
                        backgroundColor: AppColors.redColor,
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
                          localization.admin_leave_detail_reject_button_tag,
                          style: AppFontStyle.labelRegular),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.3, 45),
                        backgroundColor: AppColors.greenColor,
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
                          localization.admin_leave_detail_approve_button_tag,
                          style: AppFontStyle.labelRegular),
                    ),
                  ],
                ),
        ),
      );
    }
    return const SizedBox();
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return BlocBuilder<AdminLeaveDetailsBloc, AdminLeaveDetailsState>(
      buildWhen: (previous, current) =>
          previous.actionStatus != current.actionStatus,
      builder: (context, state) => ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          fixedSize: Size(MediaQuery.of(context).size.width * 0.918518, 45),
        ),
        child: state.actionStatus == Status.loading
            ? const AppCircularProgressIndicator(
                color: AppColors.whiteColor, size: 25)
            : Text(localization.cancel_button_tag,
                style: AppFontStyle.labelRegular),
      ),
    );
  }
}
