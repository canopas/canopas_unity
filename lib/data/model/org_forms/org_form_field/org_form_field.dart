import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org_form_field.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class OrgFormField extends Equatable {
  final String id;
  final int index;
  final String question;
  final FieldType type;
  final FieldInputType inputType;
  final List<String>? options;
  final bool isRequired;

  const OrgFormField(
      {required this.id,
      required this.index,
      required this.question,
      this.inputType = FieldInputType.text,
      this.type = FieldType.text,
      this.isRequired = false,
      this.options});

  factory OrgFormField.fromJson(Map<String, dynamic> map) =>
      _$OrgFormFieldFromJson(map);

  Map<String, dynamic> toJson() => _$OrgFormFieldToJson(this);

  factory OrgFormField.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      OrgFormField.fromJson(snapshot.data()!);

  OrgFormField copyWith(
          {String? question,
          int? index,
          bool? allowDescriptionNull,
          FieldType? type,
          FieldInputType? inputType,
          bool? allowOptionNull,
          List<String>? options,
          bool? isRequired}) =>
      OrgFormField(
          index: index ?? this.index,
          id: id,
          question: question ?? this.question,
          inputType: inputType ?? this.inputType,
          isRequired: isRequired ?? this.isRequired,
          options: options ?? (allowOptionNull == true ? null : this.options),
          type: type ?? this.type);

  @override
  List<Object?> get props =>
      [question, inputType, options, isRequired, type, index];
}

@JsonEnum(valueField: 'value')
enum FieldInputType {
  text(0),
  boolean(1),
  date(2),
  time(3),
  dropDown(4),
  checkBox(5),
  file(6),
  none(7);

  final int value;

  const FieldInputType(this.value);
}

@JsonEnum(valueField: 'value')
enum FieldType {
  text(0),
  image(1);

  final int value;

  const FieldType(this.value);
}
