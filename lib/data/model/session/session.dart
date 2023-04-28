import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  @JsonKey(name: 'device_id')
  String? deviceId;
  @JsonKey(name: 'device_token')
  String? deviceToken;
  @JsonKey(name: 'device_type')
  int? deviceType;
  int? version;
  @JsonKey(name: 'device_name')
  String? deviceName;
  @JsonKey(name: 'os_version')
  String? osVersion;
  @JsonKey(name: 'last_accessed-on')
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
