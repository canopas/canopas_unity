import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';

part 'space.g.dart';

@JsonSerializable(includeIfNull: false)
class Space {
  final String id;
  final String name;
  @JsonKey(name: 'created_at', fromJson: _fromJson, toJson: _toJson)
  final DateTime createdAt;
  final String? logo;
  @JsonKey(name: 'owner_ids')
  final List<String> ownerIds;
  @JsonKey(name: 'paid_time_off')
  final int paidTimeOff;
  final String? domain;

  Space({
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

  static DateTime _fromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int).dateOnly;
  static int _toJson(DateTime date) => date.dateOnly.millisecondsSinceEpoch;

  factory Space.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic> map = snapshot.data()!;
    return Space.fromJson(map);
  }
}
