import 'package:flutter/material.dart';
import '../../../../../../configs/text_style.dart';
import '../../../../../../core/utils/const/other_constant.dart';

class LeaveRequestSubTitle extends StatelessWidget {
  const LeaveRequestSubTitle({Key? key, required this.subtitle}) : super(key: key);
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(top: primaryHorizontalSpacing, left: 5, bottom: 8),
      child: Text(
        subtitle,
        style: AppTextStyle.leaveRequestFormSubtitle,
      ),
    );
  }
}
