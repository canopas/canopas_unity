import 'package:equatable/equatable.dart';

import '../../../../../data/model/employee/employee.dart';

abstract class EditEmployeeByAdminEvent extends Equatable {}

class EditEmployeeByAdminInitialEvent extends EditEmployeeByAdminEvent {
  final Role? roleType;
  final DateTime? dateOfJoining;
  final DateTime? dateOfBirth;

  EditEmployeeByAdminInitialEvent(
      {required this.roleType, required this.dateOfJoining,required this.dateOfBirth});

  @override
  List<Object?> get props => [roleType, dateOfJoining, dateOfBirth];
}

class ChangeEmployeeNameEvent extends EditEmployeeByAdminEvent {
  final String name;

  ChangeEmployeeNameEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class ChangeEmployeeEmailEvent extends EditEmployeeByAdminEvent {
  final String email;

  ChangeEmployeeEmailEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ChangeEmployeeIdEvent extends EditEmployeeByAdminEvent {
  final String employeeId;

  ChangeEmployeeIdEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class ChangeEmployeeDesignationEvent extends EditEmployeeByAdminEvent {
  final String designation;

  ChangeEmployeeDesignationEvent({required this.designation});

  @override
  List<Object?> get props => [designation];
}

class ChangeEmployeeRoleEvent extends EditEmployeeByAdminEvent {
  final Role roleType;

  ChangeEmployeeRoleEvent({required this.roleType});

  @override
  List<Object?> get props => [roleType];
}

class ChangeEmployeeDateOfJoiningEvent extends EditEmployeeByAdminEvent {
  final DateTime dateOfJoining;

  ChangeEmployeeDateOfJoiningEvent({required this.dateOfJoining});

  @override
  List<Object?> get props => [dateOfJoining];
}
class ChangeEmployeeDateOfBirth extends EditEmployeeByAdminEvent {
  final DateTime dateOfBirth;

  ChangeEmployeeDateOfBirth({required this.dateOfBirth});

  @override
  List<Object?> get props => [dateOfBirth];
}

class ChangeProfileImageEvent extends EditEmployeeByAdminEvent {
  final String imagePath;

  ChangeProfileImageEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class UpdateEmployeeByAdminEvent extends EditEmployeeByAdminEvent {
  final Employee previousEmployeeData;
  final String name;
  final String designation;
  final String email;
  final String employeeId;
  final String level;

  UpdateEmployeeByAdminEvent({
    required this.previousEmployeeData,
    required this.name,
    required this.designation,
    required this.email,
    required this.employeeId,
    required this.level,
  });

  @override
  List<Object?> get props =>
      [previousEmployeeData, name, designation, email, employeeId, level];
}
