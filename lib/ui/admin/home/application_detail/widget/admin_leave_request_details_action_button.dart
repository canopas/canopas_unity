import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../bloc/admin_leave_application_detail_bloc.dart';
import '../bloc/admin_leave_application_detail_event.dart';
import '../bloc/admin_leave_application_detail_state.dart';

class AdminLeaveDetailsActionButton extends StatelessWidget {
  final String leaveID;
  const AdminLeaveDetailsActionButton({
    Key? key,
    required this.leaveID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return BlocListener<AdminLeaveApplicationDetailsBloc,
            AdminLeaveApplicationDetailsState>(
        listener: (context, state) {
          if (state.adminLeaveResponseStatus ==
              AdminLeaveResponseStatus.success) {
            context.pop();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: AppTheme.commonBoxShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 45),
                  backgroundColor: AppColors.redColor,
                ),
                onPressed: () {
                  context.read<AdminLeaveApplicationDetailsBloc>().add(
                      AdminLeaveResponseEvent(
                          response: AdminLeaveResponse.reject,
                          leaveId: leaveID));
                },
                child: Text(localization.admin_leave_detail_reject_button_tag,
                    style: AppFontStyle.labelRegular),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 45),
                  backgroundColor: AppColors.greenColor,
                ),
                onPressed: () {
                  context.read<AdminLeaveApplicationDetailsBloc>().add(
                      AdminLeaveResponseEvent(
                          response: AdminLeaveResponse.approve,
                          leaveId: leaveID));
                },
                child: Text(localization.admin_leave_detail_approve_button_tag,
                    style: AppFontStyle.labelRegular),
              ),
            ],
          ),
        ));
  }
}
