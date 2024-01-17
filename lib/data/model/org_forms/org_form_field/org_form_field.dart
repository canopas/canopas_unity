import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org_form_field.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class OrgFormField extends Equatable {
  final String id;
  final int index;
  final String question;
  final FormFieldType type;
  final FormFieldAnswerType answerType;
  final List<String>? options;
  final bool isRequired;

  const OrgFormField(
      {required this.id,
      required this.index,
      required this.question,
      this.answerType = FormFieldAnswerType.text,
      this.type = FormFieldType.text,
      this.isRequired = false,
      this.options});

  factory OrgFormField.fromJson(Map<String, dynamic> map) =>
      _$OrgFormFieldFromJson(map);

  Map<String, dynamic> toJson() => _$OrgFormFieldToJson(this);

  factory OrgFormField.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      OrgFormField.fromJson(snapshot.data()!);

  @override
  List<Object?> get props =>
      [question, answerType, options, isRequired, type, index, id];
}

@JsonEnum(valueField: 'value')
enum FormFieldAnswerType {
  text(0),
  boolean(1),
  date(2),
  time(3),
  dropDown(4),
  checkBox(5),
  file(6),
  none(7);

  final int value;

  const FormFieldAnswerType(this.value);
}

@JsonEnum(valueField: 'value')
enum FormFieldType {
  text(0),
  image(1);

  final int value;

  const FormFieldType(this.value);
}
