import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../widget/user_profile_image.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.employee}) : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      margin: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing)
          .copyWith(bottom: primaryVerticalSpacing),
      padding: const EdgeInsets.symmetric(
          vertical: 30, horizontal: primaryHorizontalSpacing),
      child: Column(
        children: [
          ImageProfile(imageUrl: employee.imageUrl, radius: 45),
          const SizedBox(height: 10),
          Text(
            employee.name,
            style: AppFontStyle.titleDark,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          ValidateWidget(
            isValid: employee.designation.isNotNullOrEmpty,
            child: Text(
              employee.designation ?? "",
              style: AppFontStyle.labelGrey,
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextColumn(
                title: localization.employee_role_tag,
                subtitle: localization
                    .user_detail_role_type(employee.role.toString()),
              ),
              Container(
                height: 60,
                width: 1,
                color: AppColors.lightGreyColor,
              ),
              TextColumn(
                title: localization.employee_employeeID_tag,
                subtitle: employee.employeeId,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: AppFontStyle.labelGrey,
          ),
          const SizedBox(height: 6),
          Text(
            subtitle ?? "-",
            style: AppFontStyle.titleRegular,
          ),
        ],
      ),
    );
  }
}
