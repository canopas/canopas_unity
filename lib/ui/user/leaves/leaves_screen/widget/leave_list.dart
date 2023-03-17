import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/leave_card.dart';

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
      child: ScrollOnExpand(
        scrollOnCollapse: true,
        scrollOnExpand: true,
        child: ExpandablePanel(
            theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                hasIcon: false),
            header: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyColor,
                      fontSize: 18),
                )),
            collapsed: leaves.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16.0),
                    child: LeaveCard(
                      leave: leaves[0],
                      onTap: () {
                        context.goNamed(Routes.userLeaveDetail, params: {
                          RoutesParamsConst.leaveId: leaves[0].leaveId
                        });
                      },
                    ),
                  )
                : const SizedBox(),
            expanded: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: leaves.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final leave = leaves[index];
                  return LeaveCard(
                    onTap: () {
                      context.goNamed(Routes.userLeaveDetail,
                          params: {RoutesParamsConst.leaveId: leave.leaveId});
                    },
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
                          var controller =
                              ExpandableController.of(context, required: true)!;
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
    );
  }
}
