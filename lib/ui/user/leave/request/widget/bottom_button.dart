import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';

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
    return OutlinedButton(
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black54, fontSize: 22, fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 2, color: borderColor),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        primary: color,
        onPrimary: AppColors.peachColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      onPressed: onPress,
    );
  }
}
