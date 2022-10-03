import 'package:flutter/material.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/datetimecard/picker_card.dart';
import 'package:provider/provider.dart';
import '../../../../../../stateManager/user/leave_request_data_manager.dart';
import '../../../../../../widget/date_time_picker.dart';

class EndLeaveCard extends StatelessWidget {
  const EndLeaveCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<LeaveRequestDataManager>(
          builder: (BuildContext context, leaveService, Widget? child) =>
              DatePickerCard(
                currentDate: leaveService.endLeaveDate,
                onPress: () async {
                  DateTime date = await pickDate(context: context, initialDate: leaveService.endDateTime,onlyFutureDateSelection: true);
                  leaveService.setEndLeaveDate(date);
                },
              ),
        ),
        Consumer<LeaveRequestDataManager>(
          builder: (_, leaveService, __) => TimePickerCard(
            onPress: () async {
              TimeOfDay time = (await pickTime(context: context,initialTime: leaveService.endTime));
              leaveService.setEndTime(time);
            },
            time: leaveService.endTime,
          ),
        )
      ],
    );
  }
}
