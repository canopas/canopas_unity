import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/space_constant.dart';
import '../../../../model/leave_application.dart';
import '../../../../router/app_router.dart';
import '../../home/home_screen/widget/requests/leave_content.dart';

class ExpandableList extends StatelessWidget {
  final List<LeaveApplication> leaveApplications;
  final String title;

  const ExpandableList(
      {Key? key, required this.title, required this.leaveApplications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return ExpandableNotifier(
      initialExpanded: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ScrollOnExpand(
          child: ExpandablePanel(
              theme: const ExpandableThemeData(hasIcon: false),
              header: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                          horizontal: primaryHorizontalSpacing)
                      .copyWith(top: primaryHalfSpacing),
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title, style: AppTextStyle.titleDark),
                          Text(
                            leaveApplications.length.toString(),
                            style: AppTextStyle.titleDark,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: primaryHalfSpacing,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.dividerColor,
                      )
                    ],
                  )),
              collapsed: leaveApplications.isNotEmpty
                  ? LeaveRequestCard(
                      leaveApplication: leaveApplications[0],
                      onTap: () {
                        //TODO :Implement navigation to leave details page for admin
                        context.goNamed(Routes.adminLeaveDetails,
                            extra: leaveApplications[0]);
                      },
                    )
                  : Container(),
              expanded: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: leaveApplications
                    .map((leaveApplication) => LeaveRequestCard(
                        onTap: () {
                          context.goNamed(Routes.adminLeaveDetails,
                              extra: leaveApplication);

                          //TODO :Implement navigation to leave details page for admin
                        },
                        leaveApplication: leaveApplication))
                    .toList(),
              ),
              builder: (context, expanded, collapsed) {
                return leaveApplications.isEmpty
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
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: primaryHorizontalSpacing),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.blackColor,
                                  ),
                                  onPressed: () {
                                    controller.toggle();
                                  },
                                  child: Text(
                                    controller.expanded
                                        ? localization.user_leave_view_more_tag
                                        : localization.user_leave_show_less_tag,
                                  )),
                            );
                          })
                        ],
                      );
              }),
        ),
      ),
    );
  }
}
