import 'package:equatable/equatable.dart';

abstract class AdminEditEmployeeDetailsEvents extends Equatable {}

class AdminEditEmployeeDetailsInitialEvent
    extends AdminEditEmployeeDetailsEvents {
  final int? roleType;
  final int? dateOfJoining;

  AdminEditEmployeeDetailsInitialEvent(
      {required this.roleType, required this.dateOfJoining});

  @override
  List<Object?> get props => [roleType, dateOfJoining];
}

class ValidNameAdminEditEmployeeDetailsEvent
    extends AdminEditEmployeeDetailsEvents {
  final String name;

  ValidNameAdminEditEmployeeDetailsEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class ValidEmailAdminEditEmployeeDetailsEvent
    extends AdminEditEmployeeDetailsEvents {
  final String email;

  ValidEmailAdminEditEmployeeDetailsEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ValidEmployeeIdAdminEditEmployeeDetailsEvent
    extends AdminEditEmployeeDetailsEvents {
  final String employeeId;

  ValidEmployeeIdAdminEditEmployeeDetailsEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class ValidDesignationAdminEditEmployeeDetailsEvent
    extends AdminEditEmployeeDetailsEvents {
  final String designation;

  ValidDesignationAdminEditEmployeeDetailsEvent({required this.designation});

  @override
  List<Object?> get props => [designation];
}

class ChangeRoleTypeAdminEditEmployeeDetailsEvent
    extends AdminEditEmployeeDetailsEvents {
  final int roleType;

  ChangeRoleTypeAdminEditEmployeeDetailsEvent({required this.roleType});

  @override
  List<Object?> get props => [roleType];
}

class ChangeDateOfJoiningAdminEditEmployeeDetailsEvent
    extends AdminEditEmployeeDetailsEvents {
  final DateTime dateOfJoining;

  ChangeDateOfJoiningAdminEditEmployeeDetailsEvent(
      {required this.dateOfJoining});

  @override
  List<Object?> get props => [dateOfJoining];
}

class UpdateEmployeeDetailsAdminEditEmployeeDetailsEvent
    extends AdminEditEmployeeDetailsEvents {
  final String id;
  final String name;
  final String designation;
  final String email;
  final String employeeId;
  final String level;

  UpdateEmployeeDetailsAdminEditEmployeeDetailsEvent({
    required this.name,
    required this.designation,
    required this.email,
    required this.employeeId,
    required this.level,
    required this.id,
  });

  @override
  List<Object?> get props => [id, name, designation, email, employeeId, level];
}
