import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import '../../data/configs/colors.dart';
import 'bottom_sheet_top_divider.dart';

class CalendarCard extends StatelessWidget {
  final Widget calendar;
  final void Function(SwipeDirection)? onVerticalSwipe;

  const CalendarCard({
    Key? key,
    required this.calendar,
    required this.onVerticalSwipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleGestureDetector(
      onVerticalSwipe: onVerticalSwipe,
      child: Card(
        elevation: 6,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
        shadowColor: AppColors.primaryGray.withOpacity(0.60),
        child: Column(
          children: [
            calendar,
            const BottomSheetTopSlider(),
          ],
        ),
      ),
    );
  }
}
