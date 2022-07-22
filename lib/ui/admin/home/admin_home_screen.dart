import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/admin/home/widget/employee_list.dart';
import 'package:projectunity/ui/admin/home/widget/employee_summary_card.dart';
import 'package:projectunity/widget/expanded_app_bar.dart';

import '../../../configs/colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _stateManager = getIt<NavigationStackManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandedAppBar(
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: AppColors.whiteColor,
                      )),
                  const Text(
                    'Employee Summary',
                    style: TextStyle(
                        fontSize: titleTextSize,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 34,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        _stateManager.setBottomBar(false);
                        _stateManager.push(
                            const AdminNavigationStackItem.addMemberState());
                      }),
                ])),
            _buildYourEmployeeHeader(),
            const EmployeeListView(),
          ],
        ),
         Positioned(top: 130, right: 10, left: 10, child: EmployeeSummaryCard()),
      ],
    ));
  }

  Widget _buildYourEmployeeHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 80, bottom: 15),
      child: Text("Your Employee",
          style: TextStyle(
              fontSize: headerTextSize,
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold)),
    );
  }
}
