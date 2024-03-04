import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';

class ReasonField extends StatelessWidget {
  const ReasonField({Key? key, required this.reason, required this.title})
      : super(key: key);
  final String reason;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyle.style18
                .copyWith(color: context.colorScheme.textDisabled)),
        const SizedBox(
          height: 10,
        ),
        Text(
          reason,
          style: AppTextStyle.style16
              .copyWith(color: context.colorScheme.textPrimary),
        )
      ],
    );
  }
}
