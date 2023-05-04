import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Session {
  String? deviceId;
  String? deviceToken;
  DeviceType? deviceType;
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

enum DeviceType {
  @JsonValue(1)
  android(1),
  @JsonValue(2)
  ios(2),
  @JsonValue(3)
  web(3),
  @JsonValue(4)
  macOS(4),
  @JsonValue(5)
  linux(5),
  @JsonValue(6)
  windows(6);

  final int value;

  const DeviceType(this.value);
}
