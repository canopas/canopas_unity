import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

const int kRoleTypeAdmin = 1;
const int kRoleTypeEmployee = 2;

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

  factory Employee.fromJson(Map<String, dynamic> map) =>
      _$EmployeeFromJson(map);

  Map<String, dynamic> employeeToJson() => _$EmployeeToJson(this);

  factory Employee.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Employee(
      id: snapshot.reference.id,
      roleType: data?['role_type'],
      email: data?['email'],
      name: data?['name'],
      employeeId: data?['employee_id'],
      phone: data?['phone'],
      imageUrl: data?['image_url'],
      address: data?['address'],
      gender: data?['gender'],
      dateOfBirth: data?['date_of_birth'],
      dateOfJoining: data?['date_of_joining'],
      designation: data?['designation'],
      level: data?['level'],
      bloodGroup: data?['blood_group'],
    );
  }

  Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
        'id': instance.id,
        'role_type': instance.roleType,
        'name': instance.name,
        'email': instance.email,
        'employee_id': instance.employeeId,
        'phone': instance.phone,
        'image_url': instance.imageUrl,
        'address': instance.address,
        'gender': instance.gender,
        'date_of_birth': instance.dateOfBirth,
        'date_of_joining': instance.dateOfJoining,
        'designation': instance.designation,
        'level': instance.level,
        'blood_group': instance.bloodGroup,
      };
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

  Session(
      {this.deviceId,
      this.deviceToken,
      this.deviceType,
      this.version,
      this.deviceName,
      this.osVersion,
      this.lastAccessedOn});

  factory Session.fromJson(Map<String, dynamic> map) => _$SessionFromJson(map);

  Map<String, dynamic> sessionToJson() => _$SessionToJson(this);

  factory Session.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Session(
      deviceId: data?['device_id'],
      deviceToken: data?['device_token'],
      deviceType: data?['device_type'],
      version: data?['version'],
      deviceName: data?['device_name'],
      osVersion: data?['os_version'],
      lastAccessedOn: data?['last_accessed-on'],
    );
  }
}
