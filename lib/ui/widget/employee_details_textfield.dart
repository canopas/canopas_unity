import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../data/configs/space_constant.dart';

class FieldTitle extends StatelessWidget {
  final String title;

  const FieldTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(title,
          textAlign: TextAlign.start,
          style: AppTextStyle.style16
              .copyWith(color: context.colorScheme.textDisabled)),
    );
  }
}

class FieldEntry extends StatelessWidget {
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? errorText;
  final String? hintText;
  final int? maxLine;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final int? maxLength;

  const FieldEntry(
      {Key? key,
      this.maxLine,
      this.onChanged,
      this.errorText,
      this.hintText,
      this.controller,
      this.keyboardType,
      this.maxLength,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      maxLines: maxLine,
      maxLength: maxLength,
      controller: controller,
      autocorrect: false,
      style: AppTextStyle.style16,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(primaryHorizontalSpacing),
        fillColor: context.colorScheme.containerNormal,
        filled: true,
        errorText: errorText,
        hintStyle: AppTextStyle.style16
            .copyWith(color: context.colorScheme.textDisabled),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none),
        hintText: hintText,
      ),
    );
  }
}
