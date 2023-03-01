import 'package:flutter/material.dart';

import '../configs/colors.dart';
import '../configs/space_constant.dart';
import '../configs/text_style.dart';

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
  final String? errorText;
  final String hintText;
  final int? maxLine;
  final TextEditingController? controller;

  const FieldEntry(
      {Key? key,
      this.maxLine,
      this.onChanged,
      this.errorText,
      required this.hintText,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      maxLines: maxLine,
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
