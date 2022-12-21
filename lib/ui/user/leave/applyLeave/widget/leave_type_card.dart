import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../configs/colors.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/leave_map.dart';
import '../../../../../widget/circular_progress_indicator.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_events.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_states.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_bloc.dart';

class LeaveTypeCard extends StatelessWidget {
  const LeaveTypeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: primaryHalfSpacing, horizontal: primarySpacing),
      padding: const EdgeInsets.all(primaryVerticalSpacing)
          .copyWith(left: primaryHorizontalSpacing),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      child: Material(
        color: AppColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<LeaveRequestBloc, LeaveRequestViewState>(
              buildWhen: (previous, current) => previous.leaveCounts != current.leaveCounts || previous.leaveCountStatus != current.leaveCountStatus,
              builder: (context, state) {
                if (state.leaveCountStatus == LeaveRequestLeaveCountStatus.loading) {
                  return const AppCircularProgressIndicator(size: 28,);
                } else if (state.leaveCountStatus == LeaveRequestLeaveCountStatus.success) {
                  return Text(
                    "${state.leaveCounts.remainingLeaveCount.fixedAt(2)}/${state.leaveCounts.paidLeaveCount}",
                    style: AppTextStyle.subtitleGreyBold,
                  );
                }
                return Text("0/0", style: AppTextStyle.subtitleGreyBold,);
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: primaryHalfSpacing),
              child: Container(
                height: 50,
                width: 1,
                color: AppColors.secondaryText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(localization.leave_type_tag,
                  style: AppTextStyle.leaveRequestFormSubtitle),
            ),
            Expanded(
              flex: 12,
              child: BlocBuilder<LeaveRequestBloc, LeaveRequestViewState>(
                buildWhen: (previous, current) =>
                    previous.leaveType != current.leaveType,
                builder: (context, state) => DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    items: leaveTypeMap
                        .map((key, value) {
                          return MapEntry(
                              key,
                              DropdownMenuItem<int>(
                                value: key,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: primaryHalfSpacing,
                                    ),
                                    Flexible(
                                      child: Text(localization
                                          .leave_type_placeholder_leave_status(
                                              key)),
                                    ),
                                  ],
                                ),
                              ));
                        })
                        .values
                        .toList(),
                    value: state.leaveType,
                    onChanged: (int? value) {
                      context.read<LeaveRequestBloc>().add(
                          LeaveRequestLeaveTypeChangeEvent(leaveType: value));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
