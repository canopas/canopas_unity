import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../configs/text_style.dart';
import '../../core/utils/const/space_constant.dart';

class LeaveTypeAgoTitle extends StatelessWidget {
  const LeaveTypeAgoTitle(
      {Key? key, required this.appliedOn, required this.leaveType})
      : super(key: key);

  final String appliedOn;
  final int leaveType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: primaryHorizontalSpacing,
          left: primaryHorizontalSpacing,
          right: primaryHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)
                .leave_type_placeholder_leave_status(leaveType),
            style: AppTextStyle.titleBlack600,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            appliedOn,
            style: AppTextStyle.secondarySubtitle500,
          ),
        ],
      ),
    );
  }
}
