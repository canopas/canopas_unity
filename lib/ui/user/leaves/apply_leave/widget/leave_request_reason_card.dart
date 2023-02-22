import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../bloc/apply_leave_bloc.dart';
import '../bloc/apply_leave_event.dart';
import '../bloc/apply_leave_state.dart';

class LeaveRequestReasonCard extends StatelessWidget {
  const LeaveRequestReasonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: primaryHalfSpacing, horizontal: primarySpacing),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      padding: const EdgeInsets.all(primaryHorizontalSpacing)
          .copyWith(top: 0, bottom: primaryVerticalSpacing),
      child: BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
          buildWhen: (previous, current) =>
              current.reason != previous.reason ||
              current.showTextFieldError != previous.showTextFieldError,
          builder: (context, state) => TextField(
                style: AppTextStyle.bodyTextDark,
                cursorColor: AppColors.secondaryText,
                maxLines: 5,
                decoration: InputDecoration(
                  errorText: state.showTextFieldError
                      ? AppLocalizations.of(context)
                          .user_apply_leave_error_valid_reason
                      : null,
                  border: InputBorder.none,
                  hintText:
                      AppLocalizations.of(context).leave_reason_text_field_tag,
                  hintStyle: AppTextStyle.leaveRequestFormSubtitle,
                ),
                onChanged: (reason) {
                  context
                      .read<ApplyLeaveBloc>()
                      .add(ApplyLeaveReasonChangeEvent(reason: reason));
                },
                keyboardType: TextInputType.text,
              )),
    );
  }
}