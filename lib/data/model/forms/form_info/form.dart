import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class FormInfo extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? image;
  final bool oneTimeResponse;

  const FormInfo({
    required this.id,
    required this.title,
    this.image,
    this.description,
    this.oneTimeResponse = false,
  });

  factory FormInfo.fromJson(Map<String, dynamic> map) =>
      _$FormInfoFromJson(map);

  Map<String, dynamic> toJson() => _$FormInfoToJson(this);

  factory FormInfo.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      FormInfo.fromJson(snapshot.data()!);

  @override
  List<Object?> get props => [id, title, description, oneTimeResponse, image];
}
