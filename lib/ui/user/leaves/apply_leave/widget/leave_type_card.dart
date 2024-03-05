import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../bloc/apply_leave_bloc.dart';
import '../bloc/apply_leave_event.dart';
import '../bloc/apply_leave_state.dart';

class LeaveTypeCard extends StatelessWidget {
  const LeaveTypeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                context.l10n.user_leaves_apply_leave_type_tag,
                style: AppTextStyle.style14
                    .copyWith(color: context.colorScheme.textSecondary),
              ),
            ),
            BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
              buildWhen: (previous, current) =>
                  previous.leaveType != current.leaveType,
              builder: (context, state) => ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<LeaveType>(
                  dropdownColor: context.colorScheme.surface,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: LeaveType.values.map((leaveType) {
                    return DropdownMenuItem<LeaveType>(
                      value: leaveType,
                      child: Text(
                        context.l10n.leave_type_placeholder_text(
                            leaveType.value.toString()),
                        style: AppTextStyle.style18
                            .copyWith(color: context.colorScheme.textPrimary),
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
          ],
        ),
      ),
    );
  }
}
