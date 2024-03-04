import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/colors.dart';

class AppAlertDialogue extends StatelessWidget {
  final String title;
  final String actionButtonTitle;
  final String description;
  final void Function()? onActionButtonPressed;

  const AppAlertDialogue(
      {super.key,
      required this.title,
      required this.actionButtonTitle,
      required this.description,
      required this.onActionButtonPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: surfaceColor,
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(AppLocalizations.of(context).alert_cancel_action)),
        ElevatedButton(
            onPressed: onActionButtonPressed, child: Text(actionButtonTitle)),
      ],
    );
  }
}

showAlertDialog(
        {required BuildContext context,
        required String title,
        required String actionButtonTitle,
        required String description,
        required void Function()? onActionButtonPressed}) =>
    showAdaptiveDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: surfaceColor,
              title: Text(title),
              content: Text(description),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child:
                        Text(context.l10n.alert_cancel_action)),
                ElevatedButton(
                    onPressed: (){
                      context.pop();
                      onActionButtonPressed?.call();
                    },
                    child: Text(actionButtonTitle)),
              ],
            ));
