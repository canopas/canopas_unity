import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/model/employee/employee.dart';
import '../user_profile_image.dart';

class UserContent extends StatelessWidget {
  final Employee employee;

  const UserContent({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: primaryHalfSpacing),
      child: Row(
        children: [
          ImageProfile(radius: 30, imageUrl: employee.imageUrl),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: AppTextStyle.style16
                      .copyWith(color: context.colorScheme.textPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 3,
                ),
                ValidateWidget(
                  isValid: employee.designation.isNotNullOrEmpty,
                  child: Text(
                    employee.designation ?? '',
                    style: AppTextStyle.style14
                        .copyWith(color: context.colorScheme.textSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
