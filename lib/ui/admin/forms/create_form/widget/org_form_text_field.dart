import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import '../../../../../style/app_text_style.dart';

class FormFieldTitle extends StatelessWidget {
  final String title;

  const FormFieldTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(title, style: AppTextStyle.style16),
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
        borderSide: BorderSide(
          color: context.colorScheme.outlineColor,
        ));
    return TextFormField(
      validator: validator,
      textInputAction: textInputAction,
      onChanged: onChanged,
      maxLines: maxLine,
      maxLength: maxLength,
      controller: controller,
      cursorColor: Colors.black,
      style:
          AppTextStyle.style16.copyWith(color: context.colorScheme.textPrimary),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        isDense: true,
        filled: true,
        fillColor: context.colorScheme.surface,
        hintStyle: AppTextStyle.style16
            .copyWith(color: context.colorScheme.textDisabled),
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
