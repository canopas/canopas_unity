import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../configs/text_style.dart';
import 'overlap_profile.dart';

class TeamLeaveCard extends StatelessWidget {
  final int length;

  const TeamLeaveCard({Key? key, required this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Center(child: OverlapProfile(length: length)),
          ),
          const SizedBox(
            width: 10,
          ),
           Expanded(
              child: Text(
            //Pass name of any employee who is on leave instead of 'Radhika'
            //Minus 1 from length to maintain proper value in ui like 'Radhika and 4 others are'
            AppLocalizations.of(context)
                .user_home_placeholder_onleave_member(length - 1, 'Radhika'),
            style: AppTextStyle.subtitleTextDark,
          ))
        ],
      ),
    );
  }
}
