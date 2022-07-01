import 'package:flutter/material.dart';

SnackBar buildSnackBar(BuildContext context, String msg) {
  SnackBar snackBar;
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBar = SnackBar(content: Text(msg)));
  return snackBar;
}
