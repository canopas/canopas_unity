import 'package:flutter/material.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/space/space.dart';
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
      width: MediaQuery.of(context).size.width,
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
      child: Row(
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
              style: AppFontStyle.titleRegular
                  .copyWith(color: AppColors.whiteColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
