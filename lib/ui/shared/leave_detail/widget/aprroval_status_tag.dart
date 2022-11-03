import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/shared/leave_detail/widget/status_container/approve.dart';
import 'package:projectunity/ui/shared/leave_detail/widget/status_container/pending.dart';
import 'package:projectunity/ui/shared/leave_detail/widget/status_container/rejected.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../../../../../model/leave/leave.dart';

class ApprovalStatusTag extends StatelessWidget {
  const ApprovalStatusTag({Key? key, required this.leaveStatus, required this.rejectionReason}) : super(key: key);
  final int leaveStatus;
  final String? rejectionReason;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).user_leave_detail_approval_Status_tag, style: AppTextStyle.secondarySubtitle500,),
          const SizedBox(height: 10,),
          _buildStatus(leaveStatus, context),
          const SizedBox(height: 10,),
          (rejectionReason != null)?Text(rejectionReason!, style: AppTextStyle.subtitleTextDark,):Container(),
        ],
      ),
    );
  }
}

Widget _buildStatus(int leaveStatus, BuildContext context) {
  switch (leaveStatus) {
    case pendingLeaveStatus:
      return const PendingStatus();
    case approveLeaveStatus:
      return const ApproveStatus();
    case rejectLeaveStatus:
      return const RejectStatus();
  }
  throw Exception(AppLocalizations.of(context).error_something_went_wrong);
}
