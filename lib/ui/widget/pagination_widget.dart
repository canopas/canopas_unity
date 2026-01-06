import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
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
      color: context.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.style20.copyWith(
                color: context.colorScheme.textPrimary,
              ),
            ),
            Text(
              count.toString(),
              style: AppTextStyle.style20.copyWith(
                color: context.colorScheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveListByMonth extends StatelessWidget {
  final List<Leave> leaves;
  final bool isPaginationLoading;
  final void Function(Leave leave) onCardTap;

  const LeaveListByMonth({
    super.key,
    required this.leaves,
    required this.isPaginationLoading,
    required this.onCardTap,
  });

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
          onTap: () => onCardTap(leaves[index]),
          leave: leaves[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}
