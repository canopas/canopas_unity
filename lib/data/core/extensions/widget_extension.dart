import 'package:flutter/cupertino.dart';

extension GestureExtension on Widget {
  Widget onTapGesture(VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: this,
      ),
    );
  }
}
