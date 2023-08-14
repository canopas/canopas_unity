import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectunity/data/core/converters%20/date_converter.dart';

part 'org_form_info.g.dart';

@JsonSerializable(
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    converters: [DateTimeConverter()])
class OrgFormInfo extends Equatable {
  final String id;
  final String title;
  final DateTime createdAt;
  final String? description;
  final String? image;
  final bool oneTimeResponse;

  const OrgFormInfo({
    required this.createdAt,
    required this.id,
    required this.title,
    this.image,
    this.description,
    this.oneTimeResponse = false,
  });

  factory OrgFormInfo.fromJson(Map<String, dynamic> map) =>
      _$OrgFormInfoFromJson(map);

  Map<String, dynamic> toJson() => _$OrgFormInfoToJson(this);

  factory OrgFormInfo.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      OrgFormInfo.fromJson(snapshot.data()!);

  @override
  List<Object?> get props =>
      [id, title, description, oneTimeResponse, image, createdAt];
}
