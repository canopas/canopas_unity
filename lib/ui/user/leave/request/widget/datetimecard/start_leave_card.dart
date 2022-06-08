import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/ui/user/leave/request/widget/datetimecard/time_picker_card.dart';

import '../../../../../../utils/const/other_constant.dart';
import 'date_picker_card.dart';

class StartLeaveCard extends StatefulWidget {
  TimeOfDay time;
  int date;

  StartLeaveCard({Key? key, required this.time, required this.date})
      : super(key: key);

  @override
  State<StartLeaveCard> createState() => _StartLeaveCardState();
}

class _StartLeaveCardState extends State<StartLeaveCard> {
  late TimeOfDay time;
  late int date;

  @override
  void initState() {
    time = widget.time;
    date = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 5),
          child: Text(
            'From:',
            style: GoogleFonts.ibmPlexSans(
                color: Colors.grey, fontSize: kLeaveRequestFontSize),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [DatePickerCard(date: date), TimePickerCard(time: time)],
          ),
        )
      ],
    );
  }
}
