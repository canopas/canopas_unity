import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/colors.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/space/space.dart';
import '../../../../../style/app_text_style.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/user_profile_image.dart';

class UserProfileCard extends StatelessWidget {
  final Employee currentEmployee;
  final bool isAdminOrHr;

  const UserProfileCard(
      {Key? key, required this.currentEmployee, required this.isAdminOrHr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.profile_tag,
          style: AppTextStyle.style20,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageProfile(
              backgroundColor: AppColors.whiteColor,
              imageUrl: currentEmployee.imageUrl,
              radius: 24,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                currentEmployee.name,
                style: AppFontStyle.titleRegular.copyWith(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
                onPressed: () {
                  context.pop();
                  context.goNamed(
                      isAdminOrHr ? Routes.adminProfile : Routes.userProfile);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: textDisabledColor,
                  size: 15,
                )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(),
      ],
    );
  }
}
