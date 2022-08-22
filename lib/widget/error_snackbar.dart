import 'package:flutter/material.dart';

SnackBar showSnackBar(BuildContext context, String msg) {
  SnackBar snackBar;
  ScaffoldMessenger.of(context)
      .showSnackBar(
      snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(msg)));
  return snackBar;
}
