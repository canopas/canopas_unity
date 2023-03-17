import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';

class LeaveDetailActionButton extends StatelessWidget {
  const LeaveDetailActionButton(
      {Key? key, required this.onTap, required this.leaveStatus})
      : super(key: key);
  final VoidCallback onTap;
  final int leaveStatus;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.redColor,
        fixedSize: Size(MediaQuery.of(context).size.width * 0.918518, 45),
      ),
      child: Text(localization.delete_button_tag,
          style: AppFontStyle.labelRegular),
    );
  }
}
