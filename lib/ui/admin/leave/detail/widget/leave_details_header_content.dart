import 'package:flutter/material.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/const/other_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LeaveTypeAgoTitle extends StatelessWidget {
  const LeaveTypeAgoTitle({Key? key, required this.timeAgo, required this.leaveType}) : super(key: key);

  final String timeAgo;
  final int leaveType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: primaryHorizontalSpacing, left: primaryHorizontalSpacing, right: primaryHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).leave_details_screen_leave_type_title(leaveType),style: AppTextStyle.titleBlack600,),
          const SizedBox(height: 5,),
          Text(timeAgo,style: AppTextStyle.secondarySubtitle500,),
        ],
      ),
    );
  }
}
