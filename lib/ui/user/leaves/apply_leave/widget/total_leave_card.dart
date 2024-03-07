import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../../../data/core/utils/date_formatter.dart';
import '../bloc/apply_leave_bloc.dart';
import '../bloc/apply_leave_state.dart';

class TotalDaysMsgBox extends StatelessWidget {
  const TotalDaysMsgBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
      buildWhen: (previous, current) =>
          previous.totalLeaveDays != current.totalLeaveDays,
      builder: (context, state) => Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 20),
          child: Text(
            "  *${DateFormatter(context.l10n).getLeaveDurationPresentationLong(state.totalLeaveDays)}",
            style: AppTextStyle.style16
                .copyWith(color: context.colorScheme.tertiary),
          ),
        ),
      ),
    );
  }
}
