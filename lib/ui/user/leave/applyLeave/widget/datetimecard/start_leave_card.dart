import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../stateManager/user/leave_request_data_manager.dart';
import '../../../../../../widget/date_time_picker.dart';
import 'picker_card.dart';

class StartLeaveCard extends StatelessWidget {
  const StartLeaveCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<LeaveRequestDataManager>(
          builder: (context, _leaveService, _) => DatePickerCard(
              onPress: () async {
                DateTime date = await pickDate(context: context, initialDate: _leaveService.startDateTime, onlyFutureDateSelection: true);
                _leaveService.setStartLeaveDate(date);
              },
              currentDate: _leaveService.startLeaveDate),
        ),
        Consumer<LeaveRequestDataManager>(
          builder: (context, _leaveService, _) => TimePickerCard(
            onPress: () async {
              TimeOfDay time = (await pickTime(context: context, initialTime: _leaveService.startTime));
              _leaveService.setStartTime(time);
            },
            time: _leaveService.startTime,
          ),
        )
      ],
    );
  }
}
