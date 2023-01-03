import 'package:equatable/equatable.dart';

import '../../../../model/employee/employee.dart';

abstract class AdminEditEmployeeDetailsEvents extends Equatable {}

class GetEmployeeDetailsAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final Employee employee;
  GetEmployeeDetailsAdminEditEmployeeDetailsEvents({required this.employee});
  @override
  List<Object?> get props => [employee];
}

class ChangeNameAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String name;
  ChangeNameAdminEditEmployeeDetailsEvents({required this.name});
  @override
  List<Object?> get props => [name];
}

class ChangeEmailAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String email;
  ChangeEmailAdminEditEmployeeDetailsEvents({required this.email});
  @override
  List<Object?> get props => [email];
}

class ChangePhoneNumberAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String phoneNumber;
  ChangePhoneNumberAdminEditEmployeeDetailsEvents({required this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}

class ChangeEmployeeIdAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String employeeId;
  ChangeEmployeeIdAdminEditEmployeeDetailsEvents({required this.employeeId});
  @override
  List<Object?> get props => [employeeId];
}

class ChangeDesignationAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String designation;
  ChangeDesignationAdminEditEmployeeDetailsEvents({required this.designation});
  @override
  List<Object?> get props => [designation];
}

class ChangeRoleTypeAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final int roleType;
  ChangeRoleTypeAdminEditEmployeeDetailsEvents({required this.roleType});
  @override
  List<Object?> get props => [roleType];
}

class ChangeDateOfJoiningAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final DateTime dateOfJoining;
  ChangeDateOfJoiningAdminEditEmployeeDetailsEvents({required this.dateOfJoining});
  @override
  List<Object?> get props => [dateOfJoining];
}

class ChangeLevelAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String level;
  ChangeLevelAdminEditEmployeeDetailsEvents({required this.level});
  @override
  List<Object?> get props => [level];
}

class UpdateEmployeeDetailsAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  @override
  List<Object?> get props => [];
}







