import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/double_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../bloc/admin_leave_details_bloc.dart';
import '../bloc/admin_leave_details_state.dart';

class LeaveCountsView extends StatelessWidget {
  const LeaveCountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(primaryHorizontalSpacing),
      margin: const EdgeInsets.symmetric(
          vertical: primaryHalfSpacing, horizontal: primaryHorizontalSpacing),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: BlocBuilder<AdminLeaveDetailsBloc, AdminLeaveDetailsState>(
        buildWhen: (previous, current) =>
            previous.leaveCountStatus != current.leaveCountStatus,
        builder: (context, state) => state.leaveCountStatus == Status.loading
            ? const SizedBox(
                height: 60, child: AppCircularProgressIndicator(size: 28))
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                            state.usedLeavesCount.casualLeaves
                                .fixedAt(2)
                                .toString(),
                            style: AppFontStyle.titleDark),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)
                              .leave_type_placeholder_text(
                                  LeaveType.casualLeave.value.toString()),
                          style: AppFontStyle.bodyMedium
                              .copyWith(color: AppColors.primaryBlue),
                        )
                      ],
                    ),
                  ),
                  Container(
                      color: AppColors.dividerColor, height: 60, width: 2),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                            state.usedLeavesCount.urgentLeaves
                                .fixedAt(2)
                                .toString(),
                            style: AppFontStyle.titleDark),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)
                              .leave_type_placeholder_text(
                                  LeaveType.urgentLeave.value.toString()),
                          style: AppFontStyle.bodyMedium
                              .copyWith(color: AppColors.primaryBlue),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
