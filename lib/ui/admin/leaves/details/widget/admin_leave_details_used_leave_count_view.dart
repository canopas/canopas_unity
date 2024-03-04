import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/ui/widget/leave_count_view.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../bloc/admin_leave_details_bloc.dart';
import '../bloc/admin_leave_details_state.dart';

class LeaveCountsView extends StatelessWidget {
  const LeaveCountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminLeaveDetailsBloc, AdminLeaveDetailsState>(
      buildWhen: (previous, current) =>
          previous.leaveCountStatus != current.leaveCountStatus,
      builder: (context, state) => state.leaveCountStatus == Status.loading
          ? const SizedBox(
              height: 60, child: AppCircularProgressIndicator(size: 28))
          : UsedLeaveCountsView(leaveCounts: state.usedLeavesCount),
    );
  }
}
