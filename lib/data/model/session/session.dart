import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Session {
  String? deviceId;
  String? deviceToken;
  int? deviceType;
  int? version;
  String? deviceName;
  String? osVersion;
  int? lastAccessedOn;

  Session(
      {this.deviceId,
      this.deviceToken,
      this.deviceType,
      this.version,
      this.deviceName,
      this.osVersion,
      this.lastAccessedOn});

  factory Session.fromJson(Map<String, dynamic> map) => _$SessionFromJson(map);

  factory Session.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Map<String, dynamic> data = snapshot.data()!;
    return _$SessionFromJson(data);
  }

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
