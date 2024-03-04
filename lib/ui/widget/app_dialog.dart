import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';

showAppAlertDialog(
        {required BuildContext context,
        required String title,
        required String actionButtonTitle,
        required String description,
        required void Function()? onActionButtonPressed}) async =>
    await showAdaptiveDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: context.colorScheme.surface,
              title: Text(title),
              content: Text(description),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(context.l10n.alert_cancel_action)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onActionButtonPressed?.call();
                    },
                    child: Text(actionButtonTitle)),
              ],
            ));
