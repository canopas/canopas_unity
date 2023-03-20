import 'package:flutter/material.dart';

showAlertDialog(
        {required BuildContext context,
        required String title,
        required String description,
        List<Widget>? actions}) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: actions,
            ));
