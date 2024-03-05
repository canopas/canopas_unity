import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final Widget? body;
  final bool automaticallyImplyLeading;

  const AppPage({
    super.key,
    this.title,
    this.titleWidget,
    required this.backGroundColor,
    this.actions,
    this.leading,
    this.body,
    this.floatingActionButtonLocation= FloatingActionButtonLocation.centerFloat,
    this.automaticallyImplyLeading = true,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: (title == null && titleWidget == null) &&
              actions == null &&
              leading == null
          ? null
          : AppBar(
        backgroundColor: backGroundColor,
              title: titleWidget ?? _title(),
              actions: actions,
              leading: leading,
              automaticallyImplyLeading: automaticallyImplyLeading,
            ),
      body: body,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _title() => Text(
        title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontFamily: AppTextStyle.poppinsFontFamily),
      );
}
