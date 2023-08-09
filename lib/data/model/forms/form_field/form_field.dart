import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_field.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class FormField extends Equatable {
  final String id;
  final String title;
  final String? description;
  final FieldType type;
  final FieldInputType inputType;
  final List<String>? options;
  final bool isRequired;

  const FormField(
      {required this.id,
      required this.title,
      this.inputType = FieldInputType.text,
      this.type = FieldType.text,
      this.isRequired = false,
      this.description,
      this.options});

  factory FormField.fromJson(Map<String, dynamic> map) =>
      _$FormFieldFromJson(map);

  Map<String, dynamic> toJson() => _$FormFieldToJson(this);

  factory FormField.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      FormField.fromJson(snapshot.data()!);

  @override
  List<Object?> get props =>
      [title, description, inputType, options, isRequired, type];
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
  noInput(7);

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
