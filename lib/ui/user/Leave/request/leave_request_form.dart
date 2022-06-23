import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/ui/user/Leave/request/widget/bottom_button_bar.dart';
import 'package:projectunity/utils/const/other_constant.dart';

import '../../../../configs/colors.dart';
import '../../../../di/service_locator.dart';
import '../../../../navigation/navigation_stack_manager.dart';
import '../../../user/leave/request/widget/datetimecard/end_leave_card.dart';
import '../../../user/leave/request/widget/datetimecard/start_leave_card.dart';
import '../../../user/leave/request/widget/leave_type_card.dart';
import '../../../user/leave/request/widget/reason_card.dart';
import '../../../user/leave/request/widget/supervisor_card.dart';

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({Key? key}) : super(key: key);

  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  int startLeaveDate = 0;
  int endLeaveDate = 0;
  TimeOfDay startLeaveTime = TimeOfDay.now();
  TimeOfDay endLeaveTime = TimeOfDay.now();
  String? leaveType;
  int? employeeId;

  final TextEditingController _reasonEditingController =
      TextEditingController();
  final _stateManager = getIt<NavigationStackManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            _stateManager.pop();
          },
        ),
        centerTitle: true,
        title: const Text('Leave Request'),
        titleTextStyle: const TextStyle(
            fontSize: headerTextSize, fontWeight: FontWeight.w600),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: primaryHorizontalSpacing, vertical: 15),
        child: Stack(children: [
          SizedBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeaveTypeCard(leaveType: leaveType),
                  StartLeaveCard(
                    time: startLeaveTime,
                    date: startLeaveDate,
                  ),
                  EndLeaveCard(time: endLeaveTime, date: endLeaveDate),
                  ReasonCard(controller: _reasonEditingController),
                  SupervisorCard(
                    employeeId: employeeId,
                  ),
                  Container(height: 50)
                ],
              ),
            ),
          ),
          Positioned(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: BottomButtonBar())),
        ]),
      ),
    );
  }
}
