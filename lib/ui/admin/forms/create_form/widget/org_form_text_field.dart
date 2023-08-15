import 'package:flutter/material.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';

class FormFieldTitle extends StatelessWidget {
  final String title;

  const FormFieldTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(title, style: AppFontStyle.bodyLarge),
    );
  }
}

class OrgFormFieldEntry extends StatelessWidget {
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final String? hintText;
  final int? maxLine;
  final TextEditingController? controller;
  final int? maxLength;

  const OrgFormFieldEntry(
      {Key? key,
      this.textInputAction,
      this.validator,
      this.maxLine,
      this.onChanged,
      this.controller,
      this.maxLength,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: AppColors.dividerColor,
        ));
    return TextFormField(
      validator: validator,
      textInputAction: textInputAction,
      onChanged: onChanged,
      maxLines: maxLine,
      maxLength: maxLength,
      controller: controller,
      cursorColor: Colors.black,
      style: AppFontStyle.labelRegular,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        isDense: true,
        filled: true,
        fillColor: AppColors.whiteColor,
        hintStyle: AppFontStyle.labelGrey,
        focusedBorder: inputBorder,
        errorBorder: inputBorder,
        border: inputBorder,
        focusedErrorBorder: inputBorder,
        enabledBorder: inputBorder,
        hintText: hintText,
      ),
    );
  }
}
