import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';

class ApproveStatus extends StatelessWidget {
  const ApproveStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greenColor),
          borderRadius: BorderRadius.circular(30),
          color: AppColors.bgLidghtGreenColor),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.greenColor,
            ),
            const SizedBox(width: 5),
            Text(
              'Approved',
              style: AppTextStyle.subtitleTextDark,
            ),
          ],
        ),
      ),
    );
  }
}
