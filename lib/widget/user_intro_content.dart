import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import '../../../../configs/text_style.dart';
import '../../../../widget/user_profile_image.dart';
import '../model/employee/employee.dart';

class UserIntroContent extends StatelessWidget {
  final Employee employee;
  final void Function()? onTap;
  const UserIntroContent({
    Key? key, required this.employee, this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
             ImageProfile(
              imageUrl: employee.imageUrl,
              radius: 38,
            ),
            const SizedBox(
              width: primaryHorizontalSpacing,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: AppTextStyle.headerTextBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    employee.designation,
                    style: AppTextStyle.bodyTextDark,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,size: 20,color: AppColors.secondaryText,),
            const SizedBox(width: primaryVerticalSpacing,),
          ],
        ),
      ),
    );
  }
}
