import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/user/leave/all/widget/leave_widget.dart';

import '../../../../configs/colors.dart';

class AllLeaveScreen extends StatelessWidget {
  AllLeaveScreen({Key? key}) : super(key: key);
  final _stateManager = getIt<NavigationStackManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () {
            _stateManager.pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'All Leaves',
          style: TextStyle(
              color: AppColors.darkText,
              fontSize: headerTextSize,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
              return const LeaveWidget(
                totalLeaves: 0,
                reason: '',
                startDate: 0,
                endDate: 156465461,
                leaveType: 1,
                leaveStatus: 2,
                rejection: null,
              );
            }),
          )
        ],
      ),
    );
  }
}
