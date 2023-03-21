import 'package:flutter/material.dart';
import 'package:projectunity/data/core/exception/exception_msg.dart';

SnackBar showSnackBar(
    {required BuildContext context, String? msg, String? error}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: error != null ? Text(error.errorMessage(context)) : Text(msg!));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  return snackBar;
}
