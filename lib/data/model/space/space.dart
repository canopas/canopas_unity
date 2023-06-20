import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectunity/data/core/converters%20/date_converter.dart';

part 'space.g.dart';

@JsonSerializable(
    includeIfNull: false,
    fieldRename: FieldRename.snake,
    converters: [DateTimeConverter()])
class Space extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;
  final String? logo;
  final List<String> ownerIds;
  final int paidTimeOff;
  final String? domain;

  const Space({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.paidTimeOff,
    required this.ownerIds,
    this.domain,
    this.logo,
  });

  factory Space.fromJson(Map<String, dynamic> map) => _$SpaceFromJson(map);

  Map<String, dynamic> toFirestore() => _$SpaceToJson(this);

  factory Space.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic> map = snapshot.data()!;
    return Space.fromJson(map);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
        paidTimeOff,
        ownerIds,
        domain,
        logo,
      ];
}
