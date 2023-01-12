import 'package:equatable/equatable.dart';

abstract class EmployeeDetailEvent extends Equatable{}

class EmployeeDetailInitialLoadEvent extends EmployeeDetailEvent{
  final String employeeId;
  EmployeeDetailInitialLoadEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
class EmployeeDetailsChangeRoleTypeEvent extends EmployeeDetailEvent{
  @override
  List<Object?> get props => [];
}

class DeleteEmployeeEvent extends EmployeeDetailEvent{
  final String employeeId;
  DeleteEmployeeEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];

}