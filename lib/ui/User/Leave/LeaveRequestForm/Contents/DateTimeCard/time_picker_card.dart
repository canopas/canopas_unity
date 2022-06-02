import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../utils/Constant/color_constant.dart';
import '../../../../../../utils/Constant/other_constant.dart';

class TimePickerCard extends StatefulWidget {
  TimeOfDay time;

  TimePickerCard({Key? key, required this.time}) : super(key: key);

  @override
  State<TimePickerCard> createState() => _TimePickerCardState();
}

class _TimePickerCardState extends State<TimePickerCard> {
  late TimeOfDay time;

  @override
  void initState() {
    time = widget.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 2,
            ),
            Text(
              time.format(context),
              style: GoogleFonts.ibmPlexSans(
                  color: Colors.black87, fontSize: kLeaveRequestFontSize),
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.clock,
                color: Color(kPrimaryColour),
              ),
              onPressed: () async => await _getTime(context, time),
            ),
          ],
        ),
      ),
    );
  }

  Future<TimeOfDay?> _getTime(BuildContext context, TimeOfDay timeOfDay) async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: timeOfDay);
    if (time != null) {
      setState(() {
        timeOfDay = time;
      });
    }
    return time;
  }
}
