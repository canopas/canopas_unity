import 'package:flutter/material.dart';

class Event {
  final String name;
  final String? imageUrl;
  DateTime dateTime;

  Event({required this.name, required this.dateTime, this.imageUrl}) {
    dateTime = DateUtils.dateOnly(dateTime);
  }
}
