import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../stateManager/user/leave_request_data_manager.dart';
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
                DateTime date = await pickDate(context: context, initialDate: _leaveService.startDateTime);
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

Future<DateTime> pickDate({required BuildContext context, required DateTime initialDate}) async {
  DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
      selectableDayPredicate: (day) => day.isAfter(DateTime.now().subtract(const Duration(days: 1))),
  );
  if (pickDate == null) return initialDate;
  return pickDate;
}

Future<TimeOfDay> pickTime({required BuildContext context, required TimeOfDay initialTime}) async {
  TimeOfDay? time =
      await showTimePicker(context: context, initialTime: initialTime);
  if (time == null) return initialTime;
  return time;
}