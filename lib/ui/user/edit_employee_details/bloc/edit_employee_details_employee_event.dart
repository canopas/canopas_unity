import 'package:equatable/equatable.dart';

abstract class EmployeeEditEmployeeDetailsEvents extends Equatable {}

class EmployeeEditEmployeeDetailsInitialLoadEvent
    extends EmployeeEditEmployeeDetailsEvents {
  final int? gender;
  final int? dateOfBirth;

  EmployeeEditEmployeeDetailsInitialLoadEvent(
      {required this.gender, required this.dateOfBirth});

  @override
  List<Object?> get props => [gender, dateOfBirth];
}

class ValidDesignationEmployeeEditEmployeeDetailsEvent
    extends EmployeeEditEmployeeDetailsEvents {
  final String designation;

  ValidDesignationEmployeeEditEmployeeDetailsEvent({required this.designation});

  @override
  List<Object?> get props => [designation];
}

class ValidNameEmployeeEditEmployeeDetailsEvent
    extends EmployeeEditEmployeeDetailsEvents {
  final String name;

  ValidNameEmployeeEditEmployeeDetailsEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class ChangeDateOfBirthEvent extends EmployeeEditEmployeeDetailsEvents {
  final DateTime? dateOfBirth;

  ChangeDateOfBirthEvent({required this.dateOfBirth});

  @override
  List<Object?> get props => [dateOfBirth];
}

class ChangeGenderEvent extends EmployeeEditEmployeeDetailsEvents {
  final int? gender;

  ChangeGenderEvent({
    required this.gender,
  });

  @override
  List<Object?> get props => [gender];
}

class UpdateEmployeeDetailsEvent extends EmployeeEditEmployeeDetailsEvents {
  final String name;
  final String designation;
  final String level;
  final String phoneNumber;
  final String bloodGroup;
  final String address;

  UpdateEmployeeDetailsEvent(
      {required this.name,
      required this.designation,
      required this.phoneNumber,
      required this.bloodGroup,
      required this.address,
      required this.level});

  @override
  List<Object?> get props =>
      [name, designation, level, phoneNumber, bloodGroup, address];
}
