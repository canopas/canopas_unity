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

  String startDate = 'Start Date';
  String endDate = 'End Date';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Row(
          children: [
            IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.calendar,
                  color: Color(kPrimaryColour),
                ),
                onPressed: () async {
                  DateTime? formattedDate =
                      await getDate(context, selectedDate);
                  DateTime date = DateTime.parse(formattedDate.toString());
                  startDate = DateFormat.yMMMd().format(date);
                }),
            Text(
              startDate,
              style: GoogleFonts.ibmPlexSans(color: Colors.grey, fontSize: 17),
            )
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
