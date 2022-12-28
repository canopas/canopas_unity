import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/provider/user_data.dart';

import '../../../../configs/text_style.dart';
import '../../../../widget/user_profile_image.dart';

class UserIntroContent extends StatelessWidget {
  UserIntroContent({
    Key? key,
  }) : super(key: key);
  final UserManager _userManager = getIt<UserManager>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            const ImageProfile(
              radius: 38,
            ),
            const SizedBox(
              width: primaryHorizontalSpacing,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_userManager.userName, style: AppTextStyle.headerTextBold,overflow: TextOverflow.ellipsis,),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    _userManager.employeeDesignation,
                    style: AppTextStyle.bodyTextDark,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
