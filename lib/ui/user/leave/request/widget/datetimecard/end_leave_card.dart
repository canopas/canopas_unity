import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/ui/user/leave/request/widget/datetimecard/picker_card.dart';
import 'package:projectunity/ui/user/leave/request/widget/datetimecard/start_leave_card.dart';
import 'package:provider/provider.dart';

import '../../../../../../stateManager/user/leave_request_data_manager.dart';

class EndLeaveCard extends StatelessWidget {
  const EndLeaveCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 5),
          child: Text(
            'To:',
            style: TextStyle(color: Colors.grey, fontSize: titleTextSize),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Consumer<LeaveRequestDataManager>(
                builder: (BuildContext context, leaveService, Widget? child) =>
                    DatePickerCard(
                  currentDate: leaveService.endLeaveDate,
                  onPress: () async {
                    DateTime? date = await pickDate(context);
                    leaveService.setEndLeaveDate(date);
                  },
                ),
              ),
              Consumer<LeaveRequestDataManager>(
                builder: (_, leaveService, __) => TimePickerCard(
                  onPress: () async {
                    TimeOfDay time = (await pickTime(context));
                    leaveService.setEndTime(time);
                  },
                  time: leaveService.endTime,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
