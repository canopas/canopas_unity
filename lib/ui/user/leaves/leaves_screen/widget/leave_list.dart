import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../model/leave/leave.dart';
import 'leave_card.dart';

class LeaveList extends StatelessWidget {
  final List<Leave> leaves;
  final String title;
  const LeaveList({Key? key, required this.leaves, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return ExpandableNotifier(
      initialExpanded: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ScrollOnExpand(
          scrollOnCollapse: true,
          scrollOnExpand: true,
          child: ExpandablePanel(
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  hasIcon: false),
              header: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyColor,
                        fontSize: 18),
                  )),
              collapsed: leaves.isNotEmpty
                  ? UserLeaveCard(leave: leaves[0])
                  : Container(),
              expanded: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: leaves.length,
                  itemBuilder: (context, index) {
                    Leave leave = leaves[index];
                    return UserLeaveCard(
                      leave: leave,
                    );
                  }),
              builder: (context, expanded, collapsed) {
                return leaves.isEmpty
                    ? Center(
                        child: Text(
                        localization.user_leave_no_leaves_msg,
                        style: const TextStyle(fontSize: 15),
                      ))
                    : Column(
                        children: [
                          Expandable(collapsed: collapsed, expanded: expanded),
                          Builder(builder: (context) {
                            var controller = ExpandableController.of(context,
                                required: true)!;
                            return TextButton(
                                onPressed: () {
                                  controller.toggle();
                                },
                                child: Text(controller.expanded
                                    ? localization.user_leave_view_more_tag
                                    : localization.user_leave_show_less_tag));
                          })
                        ],
                      );
              }),
        ),
      ),
    );
  }
}
