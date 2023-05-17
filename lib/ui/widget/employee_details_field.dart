import 'package:flutter/cupertino.dart';
import '../../data/configs/space_constant.dart';
import '../../data/configs/text_style.dart';

class EmployeeDetailsField extends StatelessWidget {
  const EmployeeDetailsField(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return (subtitle != null)
        ? Padding(
            padding: const EdgeInsets.all(primaryHorizontalSpacing)
                .copyWith(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFontStyle.labelGrey,
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle!,
                  style: AppFontStyle.bodyMedium,
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
