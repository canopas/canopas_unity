import 'package:equatable/equatable.dart';

abstract class AddMemberEvent extends Equatable {
  const AddMemberEvent();
}

class SelectRoleEvent extends AddMemberEvent {
  final int? role;

  const SelectRoleEvent({this.role});

  @override
  List<Object?> get props => [role];
}

class AddEmployeeIdEvent extends AddMemberEvent {
  final String employeeId;

  const AddEmployeeIdEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class AddEmployeeNameEvent extends AddMemberEvent {
  final String name;

  const AddEmployeeNameEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class AddEmployeeEmailEvent extends AddMemberEvent {
  final String email;

  const AddEmployeeEmailEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class AddEmployeeDesignationEvent extends AddMemberEvent {
  final String designation;

  const AddEmployeeDesignationEvent({required this.designation});

  @override
  List<Object?> get props => [designation];
}

class AddDateOfJoiningDateEvent extends AddMemberEvent {
  final DateTime? dateOfJoining;

  const AddDateOfJoiningDateEvent(this.dateOfJoining);

  @override
  List<Object?> get props => [dateOfJoining];
}

class SubmitEmployeeFormEvent extends AddMemberEvent {
  const SubmitEmployeeFormEvent();

  @override
  List<Object?> get props => [];
}
