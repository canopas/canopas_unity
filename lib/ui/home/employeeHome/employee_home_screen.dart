import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/home/employeeHome/widget/leave_navigation_card.dart';
import 'package:projectunity/ui/home/employeeHome/widget/leave_status.dart';
import 'package:projectunity/ui/home/employeeHome/widget/notification_icon.dart';
import 'package:projectunity/ui/home/employeeHome/widget/team_leave_card.dart';
import 'package:projectunity/utils/const/other_constant.dart';

import '../../../../widget/expanded_app_bar.dart';
import '../../../configs/colors.dart';
import '../../../navigation/navigation_stack_item.dart';
import '../../../widget/expanded_app_bar.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  final _stateManager = getIt<NavigationStackManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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
                      Row(
                        children: const [
                          NotificationIcon(),
                          CircleAvatar(
                            child: ClipOval(
                              child: Image(
                                image:
                                AssetImage('assets/images/angelaYu.jpeg'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 60,
                        left: primaryHorizontalSpacing,
                        right: primaryHorizontalSpacing),
                    child: Column(
                      children: [
                        LeaveNavigationCard(
                            color: AppColors.primaryDarkYellow,
                            leaveText: 'All Leaves',
                            onPress: () {}),
                        LeaveNavigationCard(
                            color: AppColors.primaryGreen,
                            leaveText: 'Requested Leaves',
                            onPress: () {}),
                        LeaveNavigationCard(
                            color: AppColors.primaryBlue,
                            leaveText: 'Upcoming Leaves',
                            onPress: () {}),
                        LeaveNavigationCard(
                            color: AppColors.peachColor,
                            leaveText: 'Apply for Leave',
                            onPress: () {
                              _stateManager.setBottomBar(false);
                              _stateManager.push(const NavigationStackItem
                                  .leaveRequestState());
                            }),
                        _buildTitle(onPress: () {}),
                        const TeamLeaveCard(
                          length: 5,
                        )
                      ],
                    ))
              ],
            ),
            const Positioned(
                top: 140, right: 10, left: 10, child: LeaveStatus())
          ],
        ),
      ),
    );
  }

  Widget _buildTitle({required Function() onPress}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          const Text(
            'Who\'s on leave today?',
            style: TextStyle(
              fontSize: titleTextSize,
              color: AppColors.secondaryText,
            ),
          ),
          TextButton(
              onPressed: onPress,
              child: const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: smallTextSize,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
