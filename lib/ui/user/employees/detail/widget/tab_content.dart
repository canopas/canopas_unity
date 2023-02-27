import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../model/leave/leave.dart';
import '../../../leaves/leaves_screen/widget/leave_card.dart';

class TabContent extends StatelessWidget {
  final List<Leave> leaves;
  const TabContent({Key? key, required this.leaves}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: LeaveButton(
                  leaves: leaves,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.chat,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text('Message')
                  ],
                ),
              ),
            ),
          ),
        ],
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
          theme: const ExpandableThemeData(
            iconPadding: EdgeInsets.all(0),
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
          header: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_month_sharp,
              ),
              Text(
                localization.user_leave_upcoming_leaves_tag,
              ),
            ],
          ),
          expanded: leaves.isEmpty
              ? Text(localization.employee_empty_upcoming_leaves_view_message)
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: leaves.length,
                  itemBuilder: (context, index) {
                    Leave leave = leaves[index];
                    return UserLeaveCard(
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
          collapsed: Container(),
        ),
      ),
    );
  }
}
