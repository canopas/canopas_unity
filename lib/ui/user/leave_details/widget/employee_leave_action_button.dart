import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../widget/circular_progress_indicator.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../model/leave/leave.dart';
import '../bloc/leave_details_bloc/employee_leave_details_bloc.dart';
import '../bloc/leave_details_bloc/leave_details_state.dart';

class EmployeeLeaveDetailActionButton extends StatelessWidget {
  const EmployeeLeaveDetailActionButton({Key? key, required this.leaveStatus, required this.onPressed}) : super(key: key);
  final int leaveStatus;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return BlocBuilder<EmployeeLeaveDetailsBloc,EmployeeLeaveDetailsState>(
      buildWhen: (previous, current) => previous.leaveDetailsStatus != current.leaveDetailsStatus,
      builder: (context, state) => state.leaveDetailsStatus == EmployeeLeaveDetailsStatus.loading?const AppCircularProgressIndicator(size: 28,):ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: (leaveStatus == pendingLeaveStatus)
                ? AppColors.greyColor
                : AppColors.redColor,
            fixedSize: Size(MediaQuery.of(context).size.width * 0.918518, 45),
          ),
          child: Text(
              (leaveStatus == pendingLeaveStatus)
                  ? localization.user_leave_detail_button_cancel
                  : localization.user_leave_detail_button_delete,
              style: AppTextStyle.subtitleText),
        ),
    );
  }
}

