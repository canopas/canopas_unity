import 'package:flutter/material.dart';

extension GestureExtension on Widget {
  Widget onTapGesture(VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        child: this,
      ),
    );
  }
}
