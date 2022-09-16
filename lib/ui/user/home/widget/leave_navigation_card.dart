import 'package:flutter/material.dart';
import 'package:projectunity/configs/text_style.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius:  BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
        onTap: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: color,
              width: 5,
              height: MediaQuery.of(context).size.height*0.09,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              leaveText,
              style: AppTextStyle.subTitleTextStyle,
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
