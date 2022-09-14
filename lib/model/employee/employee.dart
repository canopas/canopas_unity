import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/const/role.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  String id;
  @JsonKey(name: 'role_type')
  int roleType = kRoleTypeEmployee;
  String name;
  String email;
  @JsonKey(name: 'employee_id')
  String employeeId;
  String designation;
  String? phone;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  String? address;
  int? gender;
  @JsonKey(name: 'date_of_birth')
  int? dateOfBirth;
  @JsonKey(name: 'date_of_joining')
  int? dateOfJoining;
  String? level;
  @JsonKey(name: 'blood_group')
  String? bloodGroup;

  Employee(
      {required this.id,
      required this.roleType,
      required this.name,
      required this.employeeId,
      required this.email,
      required this.designation,
      this.phone,
      this.imageUrl,
      this.address,
      this.gender,
      this.dateOfBirth,
      this.dateOfJoining,
      this.level,
      this.bloodGroup});

  String getRole() {
    if (roleType == kRoleTypeAdmin) {
      return "Admin";
    } else if (roleType == kRoleTypeEmployee) {
      return "Employee";
    } else {
      return "HR";
    }
  }

  factory Employee.fromJson(Map<String, dynamic>? map) =>
      _$EmployeeFromJson(map!);

  Map<String, dynamic> employeeToJson() => _$EmployeeToJson(this);

  factory Employee.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Map<String, dynamic>? data = snapshot.data();
    return Employee(
      id: data?['id'] as String,
      roleType: data?['role_type'] as int,
      name: data?['name'] as String,
      employeeId: data?['employee_id'] as String,
      email: data?['email'] as String,
      designation: data?['designation'] as String,
      phone: data?['phone'] as String?,
      imageUrl: data?['image_url'] as String?,
      address: data?['address'] as String?,
      gender: data?['gender'] as int?,
      dateOfBirth: data?['date_of_birth'] as int?,
      dateOfJoining: data?['date_of_joining'] as int?,
      level: data?['level'] as String?,
      bloodGroup: data?['blood_group'] as String?,
    );
  }
}

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

  Session({this.deviceId,
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
    Map<String, dynamic>? data = snapshot.data();
    return Session(
      deviceId: data?['device_id'] as String?,
      deviceToken: data?['device_token'] as String?,
      deviceType: data?['device_type'] as int?,
      version: data?['version'] as int?,
      deviceName: data?['device_name'] as String?,
      osVersion: data?['os_version'] as String?,
      lastAccessedOn: data?['last_accessed-on'] as int?,
    );
  }

  Map<String, dynamic> sessionToJson() => _$SessionToJson(this);
}
