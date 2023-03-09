import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/configs/text_style.dart';

import '../../../../../../configs/colors.dart';
import '../../../../../../model/employee/employee.dart';
import '../../../../../../widget/user_profile_image.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.employee}) : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Stack(
      alignment: const Alignment(0, -1),
      children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(200, 10))),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                color: AppColors.greyColor.withOpacity(0.15),
                spreadRadius: 3,
                blurRadius: 5,
              )
            ],
          ),
          margin: const EdgeInsets.only(
              top: 70.0,
              bottom: 5,
              left: primaryHorizontalSpacing,
              right: primaryHorizontalSpacing),
          padding: const EdgeInsets.only(
              top: 70.0,
              bottom: 30.0,
              left: primaryHorizontalSpacing,
              right: primaryHorizontalSpacing),
          child: Column(
            children: [
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextColumn(
                    title: localization.employee_role_tag,
                    subtitle:
                        localization.user_detail_role_type(employee.roleType.toString()),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: 1,
                    color: AppColors.greyColor,
                  ),
                  TextColumn(
                    title: localization.employee_employeeID_tag,
                    subtitle: employee.employeeId,
                  ),
                ],
              ),
            ],
          ),
        ),
        ProfilePic(imageUrl: employee.imageUrl),
      ],
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

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key? key, required this.imageUrl}) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: primaryHorizontalSpacing),
      child: CircleAvatar(
        radius: 55,
        backgroundColor: AppColors.whiteColor,
        child: ImageProfile(imageUrl: imageUrl, radius: 50),
      ),
    );
  }
}
