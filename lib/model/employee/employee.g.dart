// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['id'] as String?,
      roleType: json['role_type'] as int,
      name: json['name'] as String,
      employeeId: json['employee_id'] as String,
      email: json['email'] as String,
      designation: json['designation'] as String,
      phone: json['phone'] as String?,
      imageUrl: json['image_url'] as String?,
      address: json['address'] as String?,
      gender: json['gender'] as int?,
      dateOfBirth: json['date_of_birth'] as int?,
      dateOfJoining: json['date_of_joining'] as int?,
      level: json['level'] as String?,
      bloodGroup: json['blood_group'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'role_type': instance.roleType,
      'name': instance.name,
      'email': instance.email,
      'employee_id': instance.employeeId,
      'designation': instance.designation,
      'phone': instance.phone,
      'image_url': instance.imageUrl,
      'address': instance.address,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth,
      'date_of_joining': instance.dateOfJoining,
      'level': instance.level,
      'blood_group': instance.bloodGroup,
    };

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      deviceId: json['device_id'] as String?,
      deviceToken: json['device_token'] as String?,
      deviceType: json['device_type'] as int?,
      version: json['version'] as int?,
      deviceName: json['device_name'] as String?,
      osVersion: json['os_version'] as String?,
      lastAccessedOn: json['last_accessed-on'] as int?,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'device_id': instance.deviceId,
      'device_token': instance.deviceToken,
      'device_type': instance.deviceType,
      'version': instance.version,
      'device_name': instance.deviceName,
      'os_version': instance.osVersion,
      'last_accessed-on': instance.lastAccessedOn,
    };
