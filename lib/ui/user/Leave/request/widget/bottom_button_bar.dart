import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';

import '../../../../../configs/colors.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../navigation/navigation_stack_item.dart';
import '../../../../../navigation/navigation_stack_manager.dart';

class BottomButtonBar extends StatelessWidget {
  final _stateManager = getIt<NavigationStackManager>();

  BottomButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade50,
          blurRadius: 10,
          spreadRadius: 10,
        ),
      ]),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: titleTextSize,
                  ),
                ),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: AppColors.secondaryText),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Apply Leave',
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: titleTextSize,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onPressed: () {
                _stateManager
                    .push(const NavigationStackItem.userAllLeaveState());
                _stateManager.setBottomBar(true);
              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
