import 'package:flutter/material.dart';
import '../../../../../../configs/colors.dart';
import '../../../../../../configs/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class PendingStatus extends StatelessWidget {
  const PendingStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: FittedBox(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.blueGrey),
              borderRadius: BorderRadius.circular(30),
              color: AppColors.lightGreyColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.error,
                  color: AppColors.secondaryText,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of(context).pending_tag,
                  style: AppTextStyle.subtitleTextDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
