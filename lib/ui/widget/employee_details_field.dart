import 'package:flutter/cupertino.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../data/configs/space_constant.dart';

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
                  style: AppTextStyle.style14
                      .copyWith(color: context.colorScheme.textDisabled),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle!,
                  style: AppTextStyle.style18
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
