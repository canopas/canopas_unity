import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_bloc.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_events.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_states.dart';

class LeaveRequestReasonCard extends StatelessWidget {

  const LeaveRequestReasonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: primaryHalfSpacing,horizontal: primarySpacing),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow
      ),
      padding: const EdgeInsets.all(primaryHorizontalSpacing).copyWith(top:0,bottom: primaryVerticalSpacing),
      child: BlocBuilder<LeaveRequestBloc, LeaveRequestViewState>(
        buildWhen: (previous, current) => current.reason != previous.reason || current.showTextFieldError != previous.showTextFieldError,
          builder:(context, state) => TextField(
              style: AppTextStyle.bodyTextDark,
              cursorColor: AppColors.secondaryText,
              maxLines: 5,
              decoration: InputDecoration(
                errorText: state.showTextFieldError
                    ? AppLocalizations.of(context).user_apply_leave_error_valid_reason
                    : null,
                border: InputBorder.none,
                hintText: AppLocalizations.of(context).leave_reason_text_field_tag,
                hintStyle: AppTextStyle.leaveRequestFormSubtitle,
              ),
              onChanged: (reason) {
                context.read<LeaveRequestBloc>().add(LeaveRequestReasonChangeEvent(reason: reason));
              },
              keyboardType: TextInputType.text,
            )
      ),
    );
  }
}