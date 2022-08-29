import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/employee_summary/employees_summary.dart';
import 'package:projectunity/navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';

class EmployeeSummaryCard extends StatelessWidget {
  EmployeeSummaryCard({Key? key, required this.employeesSummary}) : super(key: key);

  final _stackManager = getIt<NavigationStackManager>();
  final EmployeesSummary employeesSummary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Card(
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSummaryContent(
                  onTap: null,
                  icon: Icons.people,
                  color: AppColors.primaryGreen,
                  title: employeesSummary.totalEmployeesCount.toString(),
                  desc: AppLocalizations.of(context).admin_home_employee_tag,
                ),
                _buildSummaryContent(
                  onTap: () {
                    _stackManager
                        .push(const AdminNavigationStackItem.adminLeaveRequestState());
                  },
                  icon: Icons.notifications_active_rounded,
                  color: AppColors.primaryDarkYellow,
                  title: employeesSummary.requestCount.toString(),
                  desc: AppLocalizations.of(context).admin_home_request_tag,
                ),
                _buildSummaryContent(
                  onTap: (){},
                  icon: Icons.calendar_month_rounded,
                  color: AppColors.primaryPink,
                  title: employeesSummary.absenceCount.toString(),
                  desc: AppLocalizations.of(context).admin_home_absence_tag,
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildSummaryContent({required icon, required color, required title, required desc, required void Function()? onTap}) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon, size: 26, color: color,
              ),
              Text(desc, style: AppTextStyle.secondaryBodyText),
              Text(title, style: AppTextStyle.headerTextBold),
            ],
          ),
        ),
      ),
    );
  }
}
