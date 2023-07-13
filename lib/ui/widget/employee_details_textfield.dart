import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/configs/colors.dart';
import '../../data/configs/space_constant.dart';
import '../../data/configs/text_style.dart';

class FieldTitle extends StatelessWidget {
  final String title;

  const FieldTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(title,
          textAlign: TextAlign.start, style: AppFontStyle.labelGrey),
    );
  }
}

class FieldEntry extends StatelessWidget {
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? errorText;
  final String? hintText;
  final int? maxLine;
  final TextInputAction textInputAction;
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
      this.inputFormatters,
      this.textInputAction = TextInputAction.next})
      : super(key: key);

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
      cursorColor: Colors.black,
      autocorrect: false,
      style: AppFontStyle.labelRegular,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(primaryHorizontalSpacing),
        fillColor: AppColors.textFieldBg,
        filled: true,
        errorText: errorText,
        hintStyle: AppFontStyle.labelGrey,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        hintText: hintText,
      ),
    );
  }
}
