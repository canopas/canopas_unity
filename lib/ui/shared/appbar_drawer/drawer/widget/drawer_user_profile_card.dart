import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/widget_extension.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../style/app_text_style.dart';
import '../../../../../app_router.dart';
import '../../../../widget/user_profile_image.dart';

class UserProfileCard extends StatelessWidget {
  final Employee currentEmployee;
  final bool isAdminOrHr;

  const UserProfileCard({
    super.key,
    required this.currentEmployee,
    required this.isAdminOrHr,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.profile_tag,
          style: AppTextStyle.style20.copyWith(
            color: context.colorScheme.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageProfile(
                backgroundColor: context.colorScheme.surface,
                imageUrl: currentEmployee.imageUrl,
                radius: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  currentEmployee.name,
                  style: AppTextStyle.style20.copyWith(
                    color: context.colorScheme.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: context.colorScheme.primary,
                size: 15,
              ),
            ],
          ),
        ).onTapGesture(() {
          context.pop();
          context.goNamed(
            isAdminOrHr ? Routes.adminProfile : Routes.userProfile,
          );
        }),
        const Divider(),
      ],
    );
  }
}
