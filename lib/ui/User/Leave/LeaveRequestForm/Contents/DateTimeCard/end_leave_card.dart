import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/Contents/DateTimeCard/date_picker_card.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/Contents/DateTimeCard/time_picker_card.dart';

import '../../../../../../utils/Constant/other_constant.dart';

class EndLeaveCard extends StatefulWidget {
  final TimeOfDay time;
  final int date;

  const EndLeaveCard({Key? key, required this.date, required this.time})
      : super(key: key);

  @override
  State<EndLeaveCard> createState() => _EndLeaveCardState();
}

class _EndLeaveCardState extends State<EndLeaveCard> {
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
            'To:',
            style: GoogleFonts.ibmPlexSans(
                color: Colors.grey, fontSize: kLeaveRequestFontSize),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [DatePickerCard(date: date), TimePickerCard(time: time)],
          ),
        )
      ],
    );
  }
}
