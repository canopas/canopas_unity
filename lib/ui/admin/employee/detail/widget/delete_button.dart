import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';

import '../../../../../../configs/colors.dart';

class DeleteButton extends StatelessWidget {
  VoidCallback onTap;

  DeleteButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.8),
          spreadRadius: 10,
          blurRadius: 5,
          offset: const Offset(0, 7),
        )
      ]),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 4),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.redColor,
            ),
            onPressed: onTap,
            child: Text(
              AppLocalizations.of(context).user_leave_detail_button_delete,
              style: AppTextStyle.subtitleText,
            )),
      ),
    );
  }
}
