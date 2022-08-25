import 'package:flutter/material.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';

class PendingStatus extends StatelessWidget {
  const PendingStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.blueGrey),
          borderRadius: BorderRadius.circular(30),
          color: AppColors.lightGreyColor),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            const Icon(
              Icons.error,
              color: AppColors.secondaryText,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Pending',
              style: AppTextStyle.subtitleTextDark,
            ),
          ],
        ),
      ),
    );
  }
}
