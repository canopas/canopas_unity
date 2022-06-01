import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/Constant/color_constant.dart';

class DatePickerCard extends StatefulWidget {
  final DateTime date;

  const DatePickerCard({Key? key, required this.date}) : super(key: key);

  @override
  State<DatePickerCard> createState() => _DatePickerCardState();
}

class _DatePickerCardState extends State<DatePickerCard> {
  late DateTime selectedDate;

  @override
  initState() {
    selectedDate = widget.date;
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
              DateFormat.yMMMd().format(selectedDate),
              style:
                  GoogleFonts.ibmPlexSans(color: Colors.black87, fontSize: 17),
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.calendar,
                color: Color(kPrimaryColour),
              ),
              onPressed: () async => await getDate(context, selectedDate),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> getDate(BuildContext context, DateTime? dateTime) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025));
    if (dateTime != DateTime.now() && dateTime != null) {
      setState(() {
        selectedDate = dateTime;
      });
    }
    return date;
  }
}
