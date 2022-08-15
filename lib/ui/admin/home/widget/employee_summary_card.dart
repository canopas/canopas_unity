import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';

class EmployeeSummaryCard extends StatelessWidget {
  EmployeeSummaryCard({Key? key}) : super(key: key);

  final _stackManager = getIt<NavigationStackManager>();

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
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSummaryContent(
                  icon: Icons.people,
                  color: AppColors.primaryGreen,
                  title: '60',
                  desc: AppLocalizations.of(context).admin_home_employee_tag,
                ),
                _buildSummaryContent(
                  icon: Icons.notifications_active_rounded,
                  color: AppColors.primaryDarkYellow,
                  title: '1',
                  desc: AppLocalizations.of(context).admin_home_request_tag,
                ),
                _buildSummaryContent(
                  icon: Icons.calendar_month_rounded,
                  color: AppColors.primaryPink,
                  title: '2',
                  desc: AppLocalizations.of(context).admin_home_absence_tag,
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildSummaryContent(
      {required icon, required color, required title, required desc}) {
    return InkWell(
      onTap: () {
        _stackManager
            .push(const AdminNavigationStackItem.adminLeaveRequestState());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: color,
          ),
          Text(desc,
              style: const TextStyle(
                  fontSize: 16, color: AppColors.secondaryText)),
          Text(title,
              style: const TextStyle(
                  fontSize: titleTextSize,
                  color: AppColors.darkText,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
