import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/text_style.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/core/utils/date_formatter.dart';
import '../bloc/apply_leave_bloc.dart';
import '../bloc/apply_leave_state.dart';

class TotalDaysMsgBox extends StatelessWidget {
  const TotalDaysMsgBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
      buildWhen: (previous, current) =>
          previous.totalLeaveDays != current.totalLeaveDays,
      builder: (context, state) => Container(
        margin: const EdgeInsets.symmetric(
            vertical: primaryHalfSpacing, horizontal: primarySpacing),
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          DateFormatter(AppLocalizations.of(context))
              .getLeaveDurationPresentationLong(state.totalLeaveDays),
          style:
              AppFontStyle.labelRegular.copyWith(color: AppColors.primaryBlue),
        ),
      ),
    );
  }
}
