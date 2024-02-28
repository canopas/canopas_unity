import 'package:flutter/material.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/colors.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/configs/text_style.dart';

class ReasonField extends StatelessWidget {
  const ReasonField({Key? key, required this.reason, required this.title})
      : super(key: key);
  final String reason;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: primaryHalfSpacing, horizontal: primaryHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.style18.copyWith(color: textDisabledColor)
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            reason,
            style: AppTextStyle.style16,
          )
        ],
      ),
    );
  }
}
