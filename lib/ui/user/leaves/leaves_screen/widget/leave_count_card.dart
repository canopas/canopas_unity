import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/double_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../style/colors.dart';
import '../bloc/leave_count/user_leave_count_bloc.dart';
import '../bloc/leave_count/user_leave_count_state.dart';

class LeaveCountCard extends StatelessWidget {
  const LeaveCountCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 80,
      margin: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        boxShadow: AppTheme.commonBoxShadow,
        borderRadius: AppTheme.commonBorderRadius,
      ),
      child: BlocConsumer<UserLeaveCountBloc, UserLeaveCountState>(
          listenWhen: (previous, current) => current.status == Status.error,
          listener: (context, state) {
            if (state.status == Status.error) {
              showSnackBar(context: context, error: state.error);
            }
          },
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          state.usedLeavesCounts.casualLeaves
                              .fixedAt(2)
                              .toString(),
                          style: AppTextStyle.style20),
                      const SizedBox(height: 4),
                      Text(
                        context.l10n.leave_type_placeholder_text(
                            LeaveType.casualLeave.value.toString()),
                        style: AppTextStyle.style16
                            .copyWith(color: context.colorScheme.primary),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 1,
                  color: containerHighColor,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          state.usedLeavesCounts.urgentLeaves
                              .fixedAt(2)
                              .toString(),
                          style: AppTextStyle.style20.copyWith(
                              color: context.colorScheme.textPrimary)),
                      const SizedBox(height: 4),
                      Text(
                        context.l10n.leave_type_placeholder_text(
                            LeaveType.urgentLeave.value.toString()),
                        style: AppTextStyle.style16
                            .copyWith(color: context.colorScheme.primary),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
