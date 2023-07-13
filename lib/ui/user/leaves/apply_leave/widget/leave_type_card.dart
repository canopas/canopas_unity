import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../bloc/apply_leave_bloc.dart';
import '../bloc/apply_leave_event.dart';
import '../bloc/apply_leave_state.dart';

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
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                localization.type_tag,
                style: AppFontStyle.labelGrey,
              ),
            ),
            Expanded(
              flex: 12,
              child: BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
                buildWhen: (previous, current) =>
                    previous.leaveType != current.leaveType,
                builder: (context, state) => DropdownButtonHideUnderline(
                  child: DropdownButton<LeaveType>(
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    borderRadius: BorderRadius.circular(12),
                    items: LeaveType.values
                        .map((leaveType) {
                          return DropdownMenuItem<LeaveType>(
                                value: leaveType,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: primaryHalfSpacing,
                                    ),
                                    Flexible(
                                      child: Text(localization
                                          .leave_type_placeholder_text(
                                          leaveType.value.toString())),
                                    ),
                                  ],
                                ),
                              );
                        }).toList(),
                    value: state.leaveType,
                    onChanged: (LeaveType? leaveType) {
                      context.read<ApplyLeaveBloc>().add(
                          ApplyLeaveChangeLeaveTypeEvent(leaveType: leaveType));
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
