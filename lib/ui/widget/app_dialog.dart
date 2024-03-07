import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';

showAppAlertDialog(
        {required BuildContext context,
        required String title,
        required String actionButtonTitle,
        required String description,
        required void Function()? onActionButtonPressed}) async =>
    await showAdaptiveDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
              backgroundColor: context.colorScheme.surface,
              title: Text(
                title,
                style: AppTextStyle.style20
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              content: Text(
                description,
                style: AppTextStyle.style16
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      context.l10n.alert_cancel_action,
                      style: AppTextStyle.style14
                          .copyWith(color: context.colorScheme.textDisable),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onActionButtonPressed?.call();
                    },
                    child: Text(
                      actionButtonTitle,
                      style: AppTextStyle.style14
                          .copyWith(color: context.colorScheme.textSecondary),
                    )),
              ],
            ));
