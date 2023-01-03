import 'package:flutter/material.dart';
import 'package:projectunity/exception/exception_msg.dart';

SnackBar showSnackBar(
    {required BuildContext context, String? msg, String? error}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: error != null ? Text(error.errorMessage(context)) : Text(msg!));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  return snackBar;
}

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Something went wrong'),
      ),
    );
  }
}
