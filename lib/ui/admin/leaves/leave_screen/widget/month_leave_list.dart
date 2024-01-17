import 'package:flutter/cupertino.dart';
import '../../../../../data/model/leave_application.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/leave_application_card.dart';
import '../../../../widget/leave_card.dart';

class MonthLeaveList extends StatelessWidget {
  final List<LeaveApplication> leaveApplications;
  final bool isPaginationLoading;
  final bool showLeaveApplicationCard;
  final void Function(LeaveApplication) onCardTap;

  const MonthLeaveList(
      {super.key,
      required this.leaveApplications,
      required this.isPaginationLoading,
      required this.showLeaveApplicationCard,
      required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: isPaginationLoading
          ? leaveApplications.length + 1
          : leaveApplications.length,
      itemBuilder: (context, index) {
        if (index == leaveApplications.length && isPaginationLoading) {
          return const Padding(
            padding: EdgeInsets.all(50),
            child: AppCircularProgressIndicator(),
          );
        }
        if (showLeaveApplicationCard) {
          return LeaveApplicationCard(
              onTap: () => onCardTap(leaveApplications[index]),
              leaveApplication: leaveApplications[index]);
        }
        return LeaveCard(
            onTap: () => onCardTap(leaveApplications[index]),
            leave: leaveApplications[index].leave);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}
