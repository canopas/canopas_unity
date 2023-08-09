
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_field_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FormFieldResponse extends Equatable {
  final String fieldId;
  final String answer;

  const FormFieldResponse({required this.fieldId, required this.answer});

  factory FormFieldResponse.fromJson(Map<String, dynamic> map) =>
      _$FormFieldResponseFromJson(map);

  Map<String, dynamic> toJson() => _$FormFieldResponseToJson(this);

  factory FormFieldResponse.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) =>
      FormFieldResponse.fromJson(snapshot.data()!);

  @override
  List<Object?> get props => [fieldId, answer];
}