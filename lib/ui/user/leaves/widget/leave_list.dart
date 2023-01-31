import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../model/leave/leave.dart';
import '../../../user/leaves/widget/leave_card.dart';

class LeaveList extends StatelessWidget {
  final List<Leave> leaves;
  final String title;
  const LeaveList({Key? key,required this.leaves,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ExpandableNotifier(
      initialExpanded: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ScrollOnExpand(
          scrollOnCollapse: true,
          scrollOnExpand: true,
          child: ExpandablePanel(
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  hasIcon: false
              ),
              header: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyColor,
                        fontSize: 18),
                  )),
              collapsed:leaves.isNotEmpty? LeaveCard(
                  totalDays: leaves[0].totalLeaves,
                  type: leaves[0].leaveType,
                  startDate: leaves[0].startDate,
                  endDate: leaves[0].endDate,
                  status: leaves[0].leaveStatus):Container(),
              expanded: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: leaves.length,
                  itemBuilder: (context, index) {
                    Leave leave = leaves[index];
                    return LeaveCard(
                      totalDays: leave.totalLeaves,
                      type: leave.leaveType,
                      startDate: leave.startDate,
                      endDate: leave.endDate,
                      status: leave.leaveStatus,
                    );
                  }),
              builder: (context, expanded, collapsed) {
                return leaves.isEmpty
                    ? const Center(child: Text('No any Leaves Yet!', style: TextStyle(fontSize: 15),))
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
                                    ? "View more"
                                    : "show less"));
                          })
                        ],
                      );
              }),
        ),
      ),
    );
  }
}
