import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';

class LeavesLeftContent extends StatelessWidget {
  const LeavesLeftContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildRemainingDays(day: 13, context: context),
          buildLeaveHistoryButton(context: context)
        ],
      ),
    );
  }

  //TODO:Add functionality so admin can see all the leaves of user by tapping on this button

  TextButton buildLeaveHistoryButton({required BuildContext context}) {
    return TextButton(
        onPressed: () {},
        child: Text(
          AppLocalizations.of(context).admin_leave_detail_button_seeHistory,
          style: const TextStyle(color: AppColors.primaryBlue),
        ));
  }

  //TODO: Count remaining leaves of user from AL
  Text buildRemainingDays({required int day, required BuildContext context}) {
    return Text(
      AppLocalizations.of(context)
          .admin_leave_detail_placeholder_remaining_days(13),
      style: const TextStyle(
          fontSize: titleTextSize,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText),
    );
  }
}
