import 'package:flutter/material.dart';
import 'package:projectunity/data/core/exception/exception_msg.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(error.errorMessage(context))));
  }
}
