import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
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
          const Expanded(
              flex: 1,
              child: Text(
                'Radhika & 4 others..',
                style: TextStyle(fontSize: 16, color: AppColors.darkText),
              ))
        ],
      ),
    );
  }
}
