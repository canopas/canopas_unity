import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';

class RejectStatus extends StatelessWidget {
  const RejectStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.redColor),
          borderRadius: BorderRadius.circular(30),
          color: AppColors.bgLightRedColor),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: const [
            Icon(
              Icons.dangerous,
              color: AppColors.redColor,
            ),
            SizedBox(width: 5),
            Text(
              'Rejected',
              style: TextStyle(
                  color: AppColors.darkText, fontSize: subTitleTextSize),
            ),
          ],
        ),
      ),
    );
  }
}
