import 'package:flutter/material.dart';
import 'package:projectunity/data/configs/colors.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/ui/widget/user_profile_image.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../data/configs/space_constant.dart';
import '../../data/configs/text_style.dart';
import '../../data/configs/theme.dart';
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
            ),
            const SizedBox(
              width: primaryHorizontalSpacing,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employee.name,
                      style: employee.status == EmployeeStatus.inactive
                          ? AppFontStyle.bodyMedium
                              .copyWith(color: AppColors.secondaryText)
                          : AppFontStyle.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                  ValidateWidget(
                    isValid: employee.designation.isNotNullOrEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(employee.designation ?? "",
                          style: employee.status == EmployeeStatus.inactive
                              ? AppFontStyle.subTitleGrey
                                  .copyWith(color: AppColors.secondaryText)
                              : AppFontStyle.subTitleGrey,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
