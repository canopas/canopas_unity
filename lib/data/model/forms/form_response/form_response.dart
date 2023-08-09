import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'form_field_response/form_field_response.dart';

part 'form_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FormResponse extends Equatable {
  final String uid;
  final String formId;
  final List<FormFieldResponse> response;

  const FormResponse(
      {required this.uid, required this.formId, required this.response});

  factory FormResponse.fromJson(Map<String, dynamic> map) =>
      _$FormResponseFromJson(map);

  Map<String, dynamic> toJson() => _$FormResponseToJson(this);

  factory FormResponse.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      FormResponse.fromJson(snapshot.data()!);

  @override
  List<Object?> get props => [uid, formId, response];
}
