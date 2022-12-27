import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../configs/theme.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../bloc/admin_leave_details_bloc.dart';
import '../bloc/admin_leave_details_event.dart';
import '../bloc/admin_leave_details_state.dart';

class AdminLeaveDetailsActionButton extends StatelessWidget {
  final String leaveID;
  const AdminLeaveDetailsActionButton({Key? key, required this.leaveID,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return BlocListener<AdminLeaveDetailsBloc,AdminLeaveDetailsState>(
      listener: (context,state) {
        if(state.leaveDetailsStatus==AdminLeaveDetailsStatus.success){
          context.pop();
        }
      },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width*0.75,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: AppTheme.commonBoxShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<AdminLeaveDetailsBloc,AdminLeaveDetailsState>(
                buildWhen: (previous, current) => previous.leaveDetailsStatus != current.leaveDetailsStatus,
                builder: (context, state) => state.leaveDetailsStatus == AdminLeaveDetailsStatus.rejectLoading?const AppCircularProgressIndicator(size: 28,):ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 45),
                    backgroundColor: AppColors.redColor,
                  ),
                  onPressed: (){
                    context.read<AdminLeaveDetailsBloc>().add(AdminLeaveDetailsRejectRequestEvent( leaveId: leaveID));
                  },
                  child: Text(
                    localization.admin_leave_detail_button_reject,
                    style: AppTextStyle.subtitleText,
                  ),
                ),
              ),
              BlocBuilder<AdminLeaveDetailsBloc,AdminLeaveDetailsState>(
                buildWhen: (previous, current) => previous.leaveDetailsStatus != current.leaveDetailsStatus,
                builder: (context, state) => state.leaveDetailsStatus == AdminLeaveDetailsStatus.approveLoading?const AppCircularProgressIndicator(size: 28,):ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 45),
                    backgroundColor: AppColors.greenColor,
                  ),
                  onPressed: (){
                    context.read<AdminLeaveDetailsBloc>().add(AdminLeaveDetailsApproveRequestEvent( leaveId: leaveID));
                  },
                  child: Text(
                    localization.admin_leave_detail_button_approve,
                    style: AppTextStyle.subtitleText,
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }
}
