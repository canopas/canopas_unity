import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';

import '../../../../../configs/colors.dart';

class LeaveNavigationCard extends StatelessWidget {
  final Color color;
  final Function() onPress;
  final String leaveText;

  const LeaveNavigationCard(
      {Key? key,
      required this.color,
      required this.leaveText,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: color,
              width: 5,
              height: 75,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              leaveText,
              style: const TextStyle(
                  fontSize: subTitleTextSize,
                  color: AppColors.darkText,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(flex: 1),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.chevron_right,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
