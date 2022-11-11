import 'package:flutter/material.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/space_constant.dart';

class ReasonField extends StatelessWidget {
  const ReasonField({Key? key, required this.reason, this.hide = false, required this.title}) : super(key: key);
  final String reason;
  final bool hide;
  final String title;

  @override
  Widget build(BuildContext context) {
    return (!hide)?Padding(
      padding: const EdgeInsets.symmetric(vertical: primaryVerticalSpacing,horizontal: primaryHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.secondarySubtitle500,),
          const SizedBox(height: 10,),
          Text(reason, style: AppTextStyle.subtitleTextDark,)
        ],
      ),
    ):const SizedBox();
  }
}
