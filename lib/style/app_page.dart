import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';

class AppPage extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Color backGroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget body;
  final bool automaticallyImplyLeading;

  const AppPage({
    super.key,
    this.title,
    this.titleWidget,
    required this.backGroundColor,
    this.actions,
    this.leading,
    required this.body,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerFloat,
    this.automaticallyImplyLeading = true,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar:
          (title == null && titleWidget == null) &&
              actions == null &&
              leading == null
          ? null
          : AppBar(
              foregroundColor: context.colorScheme.textPrimary,
              scrolledUnderElevation: 0.0,
              backgroundColor: backGroundColor,
              title: titleWidget ?? _title(context),
              actions: actions,
              leading: leading,
              automaticallyImplyLeading: automaticallyImplyLeading,
            ),
      body: body,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _title(BuildContext context) => Text(
    title ?? '',
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: AppTextStyle.poppinsFontFamily,
      fontSize: 22,
      color: context.colorScheme.textPrimary,
      fontWeight: FontWeight.w600,
    ),
  );
}
