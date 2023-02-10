import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../model/leave_application.dart';
import '../../../../../widget/circular_progress_indicator.dart';
import '../bloc/employee_leave_details_bloc.dart';
import '../bloc/leave_details_event.dart';
import '../bloc/leave_details_state.dart';

class LeaveDetailActionButton extends StatelessWidget {
  const LeaveDetailActionButton({Key? key, required this.leaveApplication})
      : super(key: key);
  final LeaveApplication leaveApplication;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return BlocBuilder<LeaveDetailsBloc, LeaveDetailsState>(
      buildWhen: (previous, current) =>
          previous.leaveDetailsStatus != current.leaveDetailsStatus,
      builder: (context, state) => state.leaveDetailsStatus ==
              LeaveDetailsStatus.loading
          ? const AppCircularProgressIndicator(
              size: 28,
            )
          : ElevatedButton(
              onPressed: () {
                context
                    .read<LeaveDetailsBloc>()
                    .add(LeaveDetailsRemoveLeaveRequestEvent(leaveApplication));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    (leaveApplication.leave.leaveStatus == pendingLeaveStatus)
                        ? AppColors.greyColor
                        : AppColors.redColor,
                fixedSize:
                    Size(MediaQuery.of(context).size.width * 0.918518, 45),
              ),
              child: Text(
                  (leaveApplication.leave.leaveStatus == pendingLeaveStatus)
                      ? localization.user_leave_detail_button_cancel
                      : localization.user_leave_detail_button_delete,
                  style: AppTextStyle.subtitleText),
            ),
    );
  }
}
