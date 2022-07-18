import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';

class LeavesLeftContent extends StatelessWidget {
  const LeavesLeftContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [buildRemainingDays(day: 13), buildLeaveHistoryButton()],
      ),
    );
  }

  TextButton buildLeaveHistoryButton() {
    return TextButton(
        onPressed: () {},
        child: const Text(
          'See History',
          style: TextStyle(color: AppColors.primaryBlue),
        ));
  }

  Text buildRemainingDays({required int day}) {
    return Text(
      'Remaining: $day/30',
      style: const TextStyle(
          fontSize: titleTextSize,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText),
    );
  }
}
