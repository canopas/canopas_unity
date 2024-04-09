import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../data/configs/space_constant.dart';

class FieldTitle extends StatelessWidget {
  final String title;

  const FieldTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(title,
          textAlign: TextAlign.start,
          style: AppTextStyle.style16
              .copyWith(color: context.colorScheme.textSecondary)),
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
  final String? labelText;
  final TextInputAction? textInputAction;

  const FieldEntry(
      {super.key,
      this.maxLine,
      this.onChanged,
      this.errorText,
      this.hintText,
      this.controller,
      this.keyboardType,
      this.maxLength,
      this.inputFormatters,
      this.labelText,
      this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      onChanged: onChanged,
      maxLines: maxLine,
      maxLength: maxLength,
      controller: controller,
      autocorrect: false,
      style:
          AppTextStyle.style16.copyWith(color: context.colorScheme.textPrimary),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        labelText: labelText,
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(primaryHorizontalSpacing),
        fillColor: context.colorScheme.containerNormal,
        filled: true,
        errorText: errorText,
        hintStyle: AppTextStyle.style16
            .copyWith(color: context.colorScheme.textSecondary),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none),
        hintText: hintText,
      ),
      onTapOutside: (pointerDownEvent) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
