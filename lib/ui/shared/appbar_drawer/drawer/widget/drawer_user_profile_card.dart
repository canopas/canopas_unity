import 'package:flutter/material.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/space/space.dart';

import '../../../../widget/space_logo_view.dart';
import '../../../../widget/user_profile_image.dart';

class UserProfileCard extends StatelessWidget {
  final Employee currentEmployee;
  final Space currentSpace;

  const UserProfileCard(
      {Key? key, required this.currentEmployee, required this.currentSpace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade700],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            tileMode: TileMode.clamp,
          ),
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Align(
                  alignment: const Alignment(-1, 0),
                  child: SpaceLogoView(spaceLogo: currentSpace.logo, size: 60)),
              Align(
                  alignment: const Alignment(-0.6, 0),
                  child: ImageProfile(
                    borderSize: 1,
                    imageUrl: currentEmployee.imageUrl,
                    radius: 30,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                currentEmployee.name,
                style: AppFontStyle.titleRegular
                    .copyWith(color: AppColors.whiteColor),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                currentSpace.name,
                style: AppFontStyle.bodyLarge
                    .copyWith(color: AppColors.whiteColor),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
