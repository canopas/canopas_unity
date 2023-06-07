import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable(includeIfNull: false)
class Employee extends Equatable {
  final String uid;
  final Role role;
  final String name;
  final String email;
  @JsonKey(name: 'employee_id')
  final String? employeeId;
  final String? designation;
  final String? phone;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? address;
  final Gender? gender;
  @JsonKey(
      name: 'date_of_birth',
      fromJson: _dateOrNullFromJson,
      toJson: _dateOrNullToJson)
  final DateTime? dateOfBirth;
  @JsonKey(
      name: 'date_of_joining', fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime dateOfJoining;
  final String? level;
  final EmployeeStatus? status;

  const Employee({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.employeeId,
    this.designation,
    this.phone,
    this.imageUrl,
    this.address,
    this.gender,
    this.dateOfBirth,
    required this.dateOfJoining,
    this.level,
    this.status,
  });

  Employee copyWith({
    String? uid,
    Role? role,
    String? name,
    String? employeeId,
    String? email,
    String? designation,
    String? phone,
    String? imageUrl,
    String? address,
    Gender? gender,
    DateTime? dateOfBirth,
    DateTime? dateOfJoining,
    String? level,
    EmployeeStatus? status,
  }) {
    return Employee(
      uid: uid ?? this.uid,
      role: role ?? this.role,
      name: name ?? this.name,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      employeeId: employeeId ?? this.employeeId,
      email: email ?? this.email,
      designation: designation ?? this.designation,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      level: level ?? this.level,
      status: status ?? this.status,
    );
  }

  static int _dateToJson(DateTime value) => value.millisecondsSinceEpoch;

  static DateTime _dateFromJson(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value);

  static int? _dateOrNullToJson(DateTime? value) =>
      value?.millisecondsSinceEpoch;

  static DateTime? _dateOrNullFromJson(int? value) =>
      value != null ? DateTime.fromMillisecondsSinceEpoch(value) : null;

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
        uid,
        role,
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
      ];
}

enum Role {
  @JsonValue(1)
  admin(1),
  @JsonValue(2)
  employee(2),
  @JsonValue(3)
  hr(3);

  final int value;

  const Role(this.value);
}

@JsonEnum(valueField: 'value')
enum EmployeeStatus {
  active(1),
  inactive(2);

  final int value;

  const EmployeeStatus(this.value);
}

@JsonEnum(valueField: 'value')
enum Gender {
  male(1),
  female(2);

  final int value;

  const Gender(this.value);
}
