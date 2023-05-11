// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$RoleEnumMap, json['role']),
      employeeId: json['employee_id'] as String?,
      designation: json['designation'] as String?,
      phone: json['phone'] as String?,
      imageUrl: json['image_url'] as String?,
      address: json['address'] as String?,
      gender: json['gender'] as int?,
      dateOfBirth: json['date_of_birth'] as int?,
      dateOfJoining: json['date_of_joining'] as int,
      level: json['level'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) {
  final val = <String, dynamic>{
    'uid': instance.uid,
    'role': _$RoleEnumMap[instance.role]!,
    'name': instance.name,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('employee_id', instance.employeeId);
  writeNotNull('designation', instance.designation);
  writeNotNull('phone', instance.phone);
  writeNotNull('image_url', instance.imageUrl);
  writeNotNull('address', instance.address);
  writeNotNull('gender', instance.gender);
  writeNotNull('date_of_birth', instance.dateOfBirth);
  val['date_of_joining'] = instance.dateOfJoining;
  writeNotNull('level', instance.level);
  writeNotNull('status', instance.status);
  return val;
}

const _$RoleEnumMap = {
  Role.admin: 1,
  Role.employee: 2,
  Role.hr: 3,
};
