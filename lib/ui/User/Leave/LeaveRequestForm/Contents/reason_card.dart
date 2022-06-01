import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/Constant/color_constant.dart';
import '../../../../../utils/Constant/other_constant.dart';

class ReasonCard extends StatefulWidget {
  TextEditingController controller;

  ReasonCard({Key? key, required this.controller}) : super(key: key);

  @override
  State<ReasonCard> createState() => _ReasonCardState();
}

class _ReasonCardState extends State<ReasonCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          style: GoogleFonts.ibmPlexSans(
              color: Colors.black87, fontSize: kLeaveRequestFontSize),
          cursorColor: const Color(kPrimaryColour),
          maxLines: 5,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Reason',
            hintStyle: GoogleFonts.ibmPlexSans(
                color: Colors.grey, fontSize: kLeaveRequestFontSize),
          ),
          autofocus: true,
          controller: _controller,
          keyboardType: TextInputType.text,
          onChanged: (data) {},
        ),
      )),
    );
  }
}
