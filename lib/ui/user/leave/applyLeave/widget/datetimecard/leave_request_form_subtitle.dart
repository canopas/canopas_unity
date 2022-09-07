import 'package:flutter/material.dart';
import '../../../../../../configs/text_style.dart';

class LeaveRequestSubTitle extends StatelessWidget {
  const LeaveRequestSubTitle({Key? key, required this.subtitle}) : super(key: key);
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5),
      child: Text(
        subtitle,
        style: AppTextStyle.leaveRequestFormSubtitle,
      ),
    );
  }
}
