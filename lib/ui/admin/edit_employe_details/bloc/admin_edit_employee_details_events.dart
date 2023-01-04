import 'package:equatable/equatable.dart';

abstract class AdminEditEmployeeDetailsEvents extends Equatable {}

class AdminEditEmployeeDetailsInitialEvent extends AdminEditEmployeeDetailsEvents{
  final int roleType;
  final int? joiningDate;
  AdminEditEmployeeDetailsInitialEvent({required this.roleType,required this.joiningDate});
  @override
  List<Object?> get props => [roleType,joiningDate];

}
class ValidNameAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String name;
  ValidNameAdminEditEmployeeDetailsEvents({required this.name});
  @override
  List<Object?> get props => [name];
}

class ValidEmailAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String email;
  ValidEmailAdminEditEmployeeDetailsEvents({required this.email});
  @override
  List<Object?> get props => [email];
}

class ValidEmployeeIdAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String employeeId;
  ValidEmployeeIdAdminEditEmployeeDetailsEvents({required this.employeeId});
  @override
  List<Object?> get props => [employeeId];
}

class ValidDesignationAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String designation;
  ValidDesignationAdminEditEmployeeDetailsEvents({required this.designation});
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


class UpdateEmployeeDetailsAdminEditEmployeeDetailsEvents extends AdminEditEmployeeDetailsEvents{
  final String name;
  final String email;
  final String designation;
  final String level;
  final String employeeId;
  final String id;

  UpdateEmployeeDetailsAdminEditEmployeeDetailsEvents({required this.id,required this.name, required this.email, required this.designation, required this.level, required this.employeeId,});
  @override
  List<Object?> get props => [name, email, designation, level, employeeId, id,];
}







