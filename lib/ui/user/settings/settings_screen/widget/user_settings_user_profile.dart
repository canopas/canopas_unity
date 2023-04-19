import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../widget/user_profile_image.dart';

class UserProfile extends StatelessWidget {
  final void Function()? onTap;
  final Employee employee;

  const UserProfile({Key? key, this.onTap, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppTheme.commonBorderRadius,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        child: Row(
          children: [
            ImageProfile(
                imageUrl: employee.imageUrl,
                radius: 28,
                backgroundColor: AppColors.dividerColor,
                iconColor: AppColors.greyColor),
            const SizedBox(width: primaryHorizontalSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: AppFontStyle.titleDark,
                    overflow: TextOverflow.fade,
                  ),
                  ValidateWidget(
                    isValid: employee.designation.isNotNullOrEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(employee.designation ?? '',
                          style: AppFontStyle.labelGrey),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.textDark,
            ),
          ],
        ),
      ),
    );
  }
}
