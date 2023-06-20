import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../core/converters /date_converter.dart';

part 'session.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake,
    includeIfNull: false,
    converters: [DateTimeConverter()])
class Session {
  String? deviceId;
  String? deviceToken;
  DeviceType? deviceType;
  int? version;
  String? deviceName;
  String? osVersion;
  DateTime? lastAccessedOn;

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

@JsonEnum(valueField: 'value')
enum DeviceType {
  android(1),
  ios(2),
  web(3),
  macOS(4),
  linux(5),
  windows(6);

  final int value;

  const DeviceType(this.value);
}
