import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../widget/user_profile_image.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageProfile(imageUrl: employee.imageUrl, radius: 45),
          const SizedBox(height: 10),
          Text(
            employee.name,
            style: AppTextStyle.style20.copyWith(
              color: context.colorScheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          ValidateWidget(
            isValid: employee.designation.isNotNullOrEmpty,
            child: Text(
              employee.designation ?? "",
              style: AppTextStyle.style14
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextColumn(
                  title: localization.employee_role_tag,
                  subtitle:
                      localization.user_detail_role_type(employee.role.name),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: context.colorScheme.outlineColor,
                ),
                TextColumn(
                  title: localization.employee_employeeID_tag,
                  subtitle: employee.employeeId,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({super.key, required this.title, required this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyle.style14
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle ?? "-",
            style: AppTextStyle.style18
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ],
      ),
    );
  }
}
