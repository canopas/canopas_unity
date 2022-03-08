// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      employeeId: json['employee_id'] as String,
      roleId: json['role_id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String,
      imageUrl: json['image_url'] as String?,
      address: json['address'] as String?,
      gender: json['gender'] as int?,
      dateOfBirth: json['date_of_birth'] as int?,
      dateOfJoining: json['date_of_joining'] as int?,
      designation: json['designation'] as String?,
      status: json['status'] as int?,
      level: json['level'] as String?,
      bloodGroup: json['blood_group'] as String?,
      session: json['session'] == null
          ? null
          : Session.fromJson(json['session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'role_id': instance.roleId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image_url': instance.imageUrl,
      'address': instance.address,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth,
      'date_of_joining': instance.dateOfJoining,
      'designation': instance.designation,
      'status': instance.status,
      'level': instance.level,
      'blood_group': instance.bloodGroup,
      'session': instance.session,
    };

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as int,
      employeeId: json['employee_id'] as int,
      deviceId: json['device_id'] as String?,
      deviceToken: json['device_token'] as String?,
      deviceType: json['device-type'] as int?,
      version: json['version'] as int?,
      deviceName: json['device_name'] as String?,
      osVersion: json['os_version'] as String?,
      lastAccessedOn: json['last_accessed-on'] as int?,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'device_id': instance.deviceId,
      'device_token': instance.deviceToken,
      'device-type': instance.deviceType,
      'version': instance.version,
      'device_name': instance.deviceName,
      'os_version': instance.osVersion,
      'last_accessed-on': instance.lastAccessedOn,
    };
