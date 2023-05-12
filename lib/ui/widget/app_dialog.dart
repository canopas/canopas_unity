import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

showAlertDialog(
        {required BuildContext context,
        required String title,
        required String actionButtonTitle,
        required String description,
        required void Function()? onActionButtonPressed}) =>
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child:
                        Text(AppLocalizations.of(context).alert_cancel_action)),
                ElevatedButton(
                    onPressed: onActionButtonPressed,
                    child: Text(actionButtonTitle)),
              ],
            ));
