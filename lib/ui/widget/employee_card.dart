import 'package:flutter/material.dart';
import 'package:projectunity/ui/widget/user_profile_image.dart';
import '../../configs/colors.dart';
import '../../configs/space_constant.dart';
import '../../configs/text_style.dart';
import '../../configs/theme.dart';
import '../../data/model/employee/employee.dart';

class EmployeeCard extends StatelessWidget {
  final void Function()? onTap;
  final Employee employee;

  const EmployeeCard({Key? key, this.onTap, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppTheme.commonBorderRadius,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: primaryVerticalSpacing, vertical: primaryHalfSpacing),
        child: Row(
          children: [
            ImageProfile(
                imageUrl: employee.imageUrl,
                radius: 25,
                backgroundColor: AppColors.dividerColor,
                iconColor: AppColors.greyColor),
            const SizedBox(
              width: primaryHorizontalSpacing,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employee.name, style: AppFontStyle.bodyMedium),
                  const SizedBox(height: 2),
                  Text(employee.designation, style: AppFontStyle.subTitleGrey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
