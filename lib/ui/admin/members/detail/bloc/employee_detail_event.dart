import 'package:equatable/equatable.dart';
import '../../../../../data/model/employee/employee.dart';

abstract class EmployeeDetailEvent extends Equatable {}

class EmployeeDetailInitialLoadEvent extends EmployeeDetailEvent {
  final String employeeId;

  EmployeeDetailInitialLoadEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class EmployeeStatusChangeEvent extends EmployeeDetailEvent {
  final String employeeId;
  final EmployeeStatus status;

  EmployeeStatusChangeEvent({required this.employeeId, required this.status});

  @override
  List<Object?> get props => [employeeId];
}

class EmployeeDisabled extends EmployeeDetailEvent {
  @override
  List<Object?> get props => [];
}
