import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  int id;
  @JsonKey(name: 'employee_id')
  String employeeId;
  @JsonKey(name: 'role_id')
  int? roleId;
  String? name;
  String email;
  String? phone;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  String? address;
  int? gender;
  @JsonKey(name: 'date_of_birth')
  int? dateOfBirth;
  @JsonKey(name: 'date_of_joining')
  int? dateOfJoining;
  String? designation;
  int? status;
  String? level;
  @JsonKey(name: 'blood_group')
  String? bloodGroup;
  Session? session;

  Employee(
      {required this.id,
      required this.employeeId,
      this.roleId,
      this.name,
      required this.email,
      this.phone,
      this.imageUrl,
      this.address,
      this.gender,
      this.dateOfBirth,
      this.dateOfJoining,
      this.designation,
      this.status,
      this.level,
      this.bloodGroup,
      this.session});

  factory Employee.fromJson(Map<String, dynamic> map) =>
      _$EmployeeFromJson(map);

  Map<String, dynamic> employeeToJson(Employee user) => _$EmployeeToJson(this);
}

@JsonSerializable()
class Session {
  int id;
  @JsonKey(name: 'employee_id')
  int employeeId;
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
      {required this.id,
      required this.employeeId,
      this.deviceId,
      this.deviceToken,
      this.deviceType,
      this.version,
      this.deviceName,
      this.osVersion,
      this.lastAccessedOn});

  factory Session.fromJson(Map<String, dynamic> map) => _$SessionFromJson(map);

  Map<String, dynamic> sessionToJson(Session session) => _$SessionToJson(this);
}
