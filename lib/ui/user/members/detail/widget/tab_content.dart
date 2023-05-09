import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/configs/text_style.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/leave_card.dart';

class TabContent extends StatelessWidget {
  final List<Leave> leaves;

  const TabContent({Key? key, required this.leaves}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(primaryHorizontalSpacing),
      child: LeaveButton(
        leaves: leaves,
      ),
    );
  }
}

class LeaveButton extends StatelessWidget {
  final List<Leave> leaves;

  const LeaveButton({Key? key, required this.leaves}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnCollapse: false,
        scrollOnExpand: true,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(hasIcon: false),
          header: Text(
            localization.user_leave_upcoming_leaves_tag,
            style: AppFontStyle.buttonTextStyle,
          ),
          expanded: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: leaves.length,
              itemBuilder: (context, index) {
                Leave leave = leaves[index];
                return LeaveCard(
                  onTap: () {
                    context.goNamed(Routes.userLeaveDetail,
                        params: {RoutesParamsConst.leaveId: leave.leaveId});
                  },
                  leave: leave,
                );
              }),
          builder: (context, collapsed, expanded) {
            return Expandable(
              collapsed: collapsed,
              expanded: expanded,
              theme: const ExpandableThemeData(crossFadePoint: 0),
            );
          },
          collapsed: const SizedBox(),
        ),
      ),
    );
  }
}
