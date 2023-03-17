import 'package:flutter/material.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/configs/text_style.dart';

class ReasonField extends StatelessWidget {
  const ReasonField(
      {Key? key, required this.reason, this.hide = false, required this.title})
      : super(key: key);
  final String reason;
  final bool hide;
  final String title;

  @override
  Widget build(BuildContext context) {
    return (!hide)
        ? Padding(
            padding: const EdgeInsets.symmetric(
                vertical: primaryHalfSpacing,
                horizontal: primaryHorizontalSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFontStyle.labelGrey,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  reason,
                  style: AppFontStyle.labelRegular,
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
