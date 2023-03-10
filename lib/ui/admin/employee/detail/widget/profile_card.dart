import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/configs/theme.dart';

import '../../../../../../configs/colors.dart';
import '../../../../../../model/employee/employee.dart';
import '../../../../../../widget/user_profile_image.dart';

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
        boxShadow: AppTheme.commonBoxShadow
      ),
      margin: const EdgeInsets.symmetric(
        horizontal:primaryHorizontalSpacing).copyWith(bottom: primaryVerticalSpacing),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: primaryHorizontalSpacing),
      child: Column(
        children: [
          ImageProfile(imageUrl: employee.imageUrl,radius: 45),
          const SizedBox(height: 10),
          Text(
            employee.name,
            style: AppFontStyle.titleDark,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            employee.designation,
            style: AppFontStyle.labelGrey,
            textAlign: TextAlign.center,
          ),
          const Divider( height: 32, thickness: 0.8, indent: 0,endIndent: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextColumn(
                title: localization.employee_role_tag,
                subtitle:
                    localization.user_detail_role_type(employee.roleType.toString()),
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
