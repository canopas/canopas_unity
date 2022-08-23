import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/core/utils/const/image_constant.dart';

import '../configs/colors.dart';

class EmptyLeaveScreen extends StatelessWidget {
  const EmptyLeaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(emptyLeaveStateImage),
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(AppLocalizations.of(context).empty_leave_state_message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: subTitleTextSize,
                )),
          ],
        ),
      ),
    );
  }
}
