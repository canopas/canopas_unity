import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectunity/data/core/converters%20/date_converter.dart';
import 'org_form_field_response/org_form_field_response.dart';

part 'org_form_response.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, converters: [DateTimeConverter()])
class OrgFormResponse extends Equatable {
  final String uid;
  final String formId;
  final DateTime submittedAt;
  final List<OrgFormFieldResponse> response;

  const OrgFormResponse(
      {required this.submittedAt,
      required this.uid,
      required this.formId,
      required this.response});

  factory OrgFormResponse.fromJson(Map<String, dynamic> map) =>
      _$OrgFormResponseFromJson(map);

  Map<String, dynamic> toJson() => _$OrgFormResponseToJson(this);

  factory OrgFormResponse.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      OrgFormResponse.fromJson(snapshot.data()!);

  @override
  List<Object?> get props => [uid, formId, response, submittedAt];
}
