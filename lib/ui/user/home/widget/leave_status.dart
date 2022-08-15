import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/font_size.dart';

import '../../../../../configs/colors.dart';

class LeaveStatus extends StatelessWidget {
  const LeaveStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
          color: AppColors.primaryDarkYellow,
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LeaveInfo(
                    title: AppLocalizations.of(context).user_home_available_tag,
                    value: 7,
                  ),
                  Container(
                    width: 1,
                    color: Colors.grey,
                  ),
                  LeaveInfo(
                      title: AppLocalizations.of(context).user_home_all_tag,
                      value: 30),
                  Container(
                    width: 1,
                    color: AppColors.secondaryText,
                  ),
                  LeaveInfo(
                      title: AppLocalizations.of(context).user_home_used_tag,
                      value: 23),
                ],
              ),
            ),
          )),
    );
  }
}

class LeaveInfo extends StatelessWidget {
  final String title;
  final int value;

  const LeaveInfo({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColors.blueGrey, fontSize: bodyTextSize),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(AppLocalizations.of(context).user_home_placeholder_leave(value),
            style: const TextStyle(
                color: AppColors.darkText,
                fontSize: subTitleTextSize,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}
