import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';

class ReasonField extends StatelessWidget {
  const ReasonField({super.key, required this.reason, required this.title});
  final String reason;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.style18.copyWith(
            color: context.colorScheme.textSecondary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          reason,
          style: AppTextStyle.style16.copyWith(
            color: context.colorScheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
