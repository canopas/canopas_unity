
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org_form_field_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrgFormFieldResponse extends Equatable {
  final String fieldId;
  final String answer;

  const OrgFormFieldResponse({required this.fieldId, required this.answer});

  factory OrgFormFieldResponse.fromJson(Map<String, dynamic> map) =>
      _$OrgFormFieldResponseFromJson(map);

  Map<String, dynamic> toJson() => _$OrgFormFieldResponseToJson(this);

  factory OrgFormFieldResponse.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) =>
      OrgFormFieldResponse.fromJson(snapshot.data()!);

  @override
  List<Object?> get props => [fieldId, answer];
}