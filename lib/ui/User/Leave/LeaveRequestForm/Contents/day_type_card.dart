import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/Constant/color_constant.dart';
import '../../../../../utils/Constant/other_constant.dart';

class DayTypeCard extends StatefulWidget {
  const DayTypeCard({Key? key}) : super(key: key);

  @override
  State<DayTypeCard> createState() => _DayTypeCardState();
}

class _DayTypeCardState extends State<DayTypeCard> {
  bool fullDaySelected = false;
  bool halfDaySelected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(kPrimaryColour)),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                setState(() {
                  fullDaySelected = !fullDaySelected;
                  halfDaySelected = !halfDaySelected;
                });
              },
              child: Text(
                'Full-day',
                style: GoogleFonts.ibmPlexSans(
                    color: Colors.black87, fontSize: kLeaveRequestFontSize),
              ),
              style: ElevatedButton.styleFrom(
                primary: fullDaySelected
                    ? Colors.white
                    : const Color(kPrimaryColour),
                onPrimary: Color(kPrimaryColour),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            )),
            Expanded(
                child: TextButton(
              onPressed: () {
                setState(() {
                  fullDaySelected = !fullDaySelected;
                  halfDaySelected = !halfDaySelected;
                });
              },
              child: Text('Half-day',
                  style: GoogleFonts.ibmPlexSans(
                      color: Colors.black87, fontSize: kLeaveRequestFontSize)),
              style: ElevatedButton.styleFrom(
                primary: halfDaySelected
                    ? Colors.white
                    : const Color(kPrimaryColour),
                onPrimary: Color(kPrimaryColour),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
