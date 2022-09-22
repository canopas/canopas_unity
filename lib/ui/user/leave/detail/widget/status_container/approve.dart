import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';
import '../../../../../../configs/colors.dart';
import '../../../../../../configs/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ApproveStatus extends StatelessWidget {
  const ApproveStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.greenColor),
            borderRadius: BorderRadius.circular(30),
            color: AppColors.bgLidghtGreenColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: primaryVerticalSpacing),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.greenColor,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context).approved_tag,
                style: AppTextStyle.subtitleTextDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
