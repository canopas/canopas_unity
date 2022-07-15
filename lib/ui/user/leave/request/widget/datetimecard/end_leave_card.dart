import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/ui/user/leave/request/widget/datetimecard/picker_card.dart';
import 'package:projectunity/ui/user/leave/request/widget/datetimecard/start_leave_card.dart';
import 'package:provider/provider.dart';

import '../../../../../../stateManager/apply_leave_state_provider.dart';
import '../../../../../../utils/const/other_constant.dart';

class EndLeaveCard extends StatelessWidget {
  const EndLeaveCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 5),
          child: Text(
            'To:',
            style: GoogleFonts.ibmPlexSans(
                color: Colors.grey, fontSize: kLeaveRequestFontSize),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Consumer<ApplyLeaveStateProvider>(
                builder: (BuildContext context, leaveService, Widget? child) =>
                    DatePickerCard(
                  currentDate: leaveService.endLeaveDate,
                  onPress: () async {
                    DateTime? date = await pickDate(context);
                    leaveService.setEndLeaveDate(date);
                  },
                ),
              ),
              Consumer<ApplyLeaveStateProvider>(
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
