import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectunity/data/core/exception/exception_msg.dart';

void showSnackBar({required BuildContext context, String? msg, String? error}) {
  if (kIsWeb || !Platform.isIOS) {
    final snackBar = SnackBar(
      content: error != null ? Text(error.errorMessage(context)) : Text(msg!),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    Fluttertoast.showToast(
      msg: error != null ? error.errorMessage(context) : msg!,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
