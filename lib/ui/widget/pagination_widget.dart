import 'package:flutter/material.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/text_style.dart';
import '../../data/model/leave/leave.dart';
import 'circular_progress_indicator.dart';
import 'leave_card.dart';

class LeaveListHeader extends StatelessWidget {
  final int count;
  final String title;

  const LeaveListHeader({super.key, required this.count, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: AppColors.whiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: AppFontStyle.headerDark),
                  Text(
                    count.toString(),
                    style: AppFontStyle.headerDark,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1)
          ],
        ));
  }
}

class LeaveListByMonth extends StatelessWidget {
  final List<Leave> leaves;
  final bool isPaginationLoading;
  final void Function(Leave leave) onCardTap;

  const LeaveListByMonth(
      {super.key,
      required this.leaves,
      required this.isPaginationLoading,
      required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: isPaginationLoading ? leaves.length + 1 : leaves.length,
      itemBuilder: (context, index) {
        if (index == leaves.length && isPaginationLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: AppCircularProgressIndicator(),
          );
        }
        return LeaveCard(
            onTap: () => onCardTap(leaves[index]), leave: leaves[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}
