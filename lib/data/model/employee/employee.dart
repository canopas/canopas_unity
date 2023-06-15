import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectunity/data/core/converters%20/date_converter.dart';

part 'employee.g.dart';

@JsonSerializable(
    includeIfNull: false,
    converters: [DateTimeConverter()],
    fieldRename: FieldRename.snake)
class Employee extends Equatable {
  final String uid;
  final Role role;
  final String name;
  final String email;
  final String? employeeId;
  final String? designation;
  final String? phone;
  final String? imageUrl;
  final String? address;
  final Gender? gender;
  final DateTime? dateOfBirth;
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

@JsonEnum(valueField: 'value')
enum Role {
  admin(1),
  employee(2),
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
