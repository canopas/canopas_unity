import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../../../../../ui/user/leave/applyLeave/bloc/leave_request_form_bloc/leave_request_view_states.dart';
import '../../../../../widget/circular_progress_indicator.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_bloc.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_events.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
      child: BlocBuilder<LeaveRequestBloc, LeaveRequestViewState>(
          builder: (context, state) => state.leaveRequestStatus ==
                  LeaveRequestStatus.loading
              ? const kCircularProgressIndicator()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      elevation: 2),
                  onPressed: () {
                    context
                        .read<LeaveRequestBloc>()
                        .add(LeaveRequestApplyLeaveEvent());
                  },
                  child: Text(localization.user_apply_leave_button_apply_leave,
                      style: AppTextStyle.subtitleTextWhite))),
    );
  }
}
