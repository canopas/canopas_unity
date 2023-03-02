import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/space_constant.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../widget/user_profile_image.dart';

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
                radius: 25,
                borderColor: AppColors.textDark,
                borderSize: 1,
                backgroundColor: AppColors.dividerColor,
                iconColor: AppColors.greyColor),
            const SizedBox(
              width: primaryHorizontalSpacing,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: AppFontStyle.titleDark,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 2),
                  Text(employee.designation, style: AppFontStyle.labelGrey),
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
