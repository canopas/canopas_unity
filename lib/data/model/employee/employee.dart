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
  final int? gender;
  @JsonKey(name: 'date_of_birth')
  final int? dateOfBirth;
  @JsonKey(name: 'date_of_joining')
  final int dateOfJoining;
  final String? level;
  final int? status;

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

  Employee copyWith(
      {String? uid,
      Role? role,
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
    int? status,
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

class EmployeeGender {
  static const int male = 1;
  static const int female = 2;
  static const List<int> values = [male, female];
}
