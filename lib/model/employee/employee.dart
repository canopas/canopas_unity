import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee extends Equatable {
  final String id;
  @JsonKey(name: 'role_type')
  final int roleType;
  final String name;
  final String email;
  @JsonKey(name: 'employee_id')
  final String employeeId;
  final String designation;
  final String? phone;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? address;
  final int? gender;
  @JsonKey(name: 'date_of_birth')
  final int? dateOfBirth;
  @JsonKey(name: 'date_of_joining')
  final int? dateOfJoining;
  final String? level;
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;

  const Employee(
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

  Employee copyWith(
      {String? id,
      int? roleType,
      String? name,
      String? employeeId,
      String? email,
      String? designation,
      String? phone,
      String? imageUrl,
      String? address,
      int? gender,
      int? dateOfBirth,
      int? dateOfJoining,
      String? level,
      String? bloodGroup}) {
    return Employee(
        id: id ?? this.id,
        roleType: roleType ?? this.roleType,
        name: name ?? this.name,
        employeeId: employeeId ?? this.employeeId,
        email: email ?? this.email,
        designation: designation ?? this.designation,
        phone: phone ?? this.phone,
        imageUrl: imageUrl ?? this.imageUrl,
        address: address ?? this.address,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        dateOfJoining: dateOfJoining ?? this.dateOfJoining,
        level: level ?? this.level,
        bloodGroup: bloodGroup ?? this.bloodGroup);
  }

  factory Employee.fromJson(Map<String, dynamic>? map) =>
      _$EmployeeFromJson(map!);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  factory Employee.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Map<String, dynamic>? data = snapshot.data();
    return Employee.fromJson(data!);
  }

  @override
  List<Object?> get props => [
        id,
        roleType,
        name,
        employeeId,
        email,
        designation,
        phone,
        imageUrl,
        address,
        gender,
        dateOfBirth,
        dateOfJoining,
        level,
        bloodGroup
      ];
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
