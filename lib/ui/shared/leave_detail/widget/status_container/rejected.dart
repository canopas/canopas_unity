import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import '../../../../../../configs/colors.dart';

class RejectStatus extends StatelessWidget {
  const RejectStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.redColor),
            borderRadius: BorderRadius.circular(30),
            color: AppColors.bgLightRedColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: primaryVerticalSpacing),
          child: Row(
            children:  [
              const Icon(
                Icons.dangerous,
                color: AppColors.redColor,
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context).rejected_tag,
                style: AppTextStyle.subtitleTextDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
