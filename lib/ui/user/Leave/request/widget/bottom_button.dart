import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/const/color_constant.dart';

class BottomButton extends StatelessWidget {
  final String text;
  VoidCallback onPress;
  final Color color;
  final Color borderColor;

  BottomButton(
      {Key? key,
      required this.text,
      required this.onPress,
      required this.color,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade50,
          blurRadius: 10,
          spreadRadius: 15,
        ),
      ]),
      child: OutlinedButton(
        child: Text(
          text,
          style: GoogleFonts.ibmPlexSans(
              color: Colors.black54, fontSize: 22, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          side: BorderSide(width: 2, color: borderColor),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          primary: color,
          onPrimary: const Color(kPrimaryColour),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onPressed: onPress,
      ),
    );
  }
}
