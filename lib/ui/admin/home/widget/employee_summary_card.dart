import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/font_size.dart';

class EmployeeSummaryCard extends StatelessWidget {
  const EmployeeSummaryCard({Key? key}) : super(key: key);

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
                  desc: 'Employee',
                ),
                _buildSummaryContent(
                  icon: Icons.notifications_active_rounded,
                  color: AppColors.primaryDarkYellow,
                  title: '1',
                  desc: 'Leave Request',
                ),
                _buildSummaryContent(
                  icon: Icons.calendar_month_rounded,
                  color: AppColors.primaryPink,
                  title: '2',
                  desc: 'Absence',
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildSummaryContent(
      {required icon, required color, required title, required desc}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 26,
          color: color,
        ),
        Text(desc,
            style:
                const TextStyle(fontSize: 16, color: AppColors.secondaryText)),
        Text(title,
            style: TextStyle(
                fontSize: titleTextSize,
                color: AppColors.darkText,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
