import 'package:equatable/equatable.dart';
import '../../../../../data/model/org_forms/org_form_field/org_form_field.dart';
import 'package:flutter/cupertino.dart' show TextEditingController;

class OrgFormFieldCreateFormState extends Equatable {
  final String id;
  final int index;
  final TextEditingController question;
  final String image;
  final FormFieldType type;
  final FormFieldAnswerType inputType;
  final List<TextEditingController>? options;
  final bool isRequired;

  const OrgFormFieldCreateFormState(
      {required this.id,
      required this.index,
      required this.question,
      this.image = '',
      this.inputType = FormFieldAnswerType.text,
      this.type = FormFieldType.text,
      this.isRequired = false,
      this.options});

  OrgFormFieldCreateFormState copyWith(
          {int? index,
          FormFieldType? type,
          String? image,
          FormFieldAnswerType? inputType,
          bool? allowOptionNull,
          List<TextEditingController>? options,
          bool? isRequired}) =>
      OrgFormFieldCreateFormState(
          image: image ?? this.image,
          index: index ?? this.index,
          id: id,
          inputType: inputType ?? this.inputType,
          isRequired: isRequired ?? this.isRequired,
          options:
              options ?? (allowOptionNull == true ? options : this.options),
          type: type ?? this.type,
          question: question);

  @override
  List<Object?> get props =>
      [question, inputType, options, isRequired, type, index, image, id];
}
