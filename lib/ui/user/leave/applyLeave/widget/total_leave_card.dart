import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/configs/text_style.dart';
import '../../../../../configs/colors.dart';
import '../../../../../core/utils/const/space_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_bloc.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_states.dart';

class TotalDaysMsgBox extends StatelessWidget {
  const TotalDaysMsgBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveRequestBloc, LeaveRequestViewState>(
      buildWhen: (previous, current) => previous.totalLeaveDays != current.totalLeaveDays,
      builder: (context, state) => Container(
        margin: const EdgeInsets.symmetric(vertical: primaryHalfSpacing, horizontal: primarySpacing),
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(DateFormatter(AppLocalizations.of(context)).getLeaveDurationPresentationLong(state.totalLeaveDays),
          style: AppTextStyle.subtitleText.copyWith(color: AppColors.primaryBlue),
        ),
      ),
    );
  }
}
