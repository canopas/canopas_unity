import 'package:equatable/equatable.dart';

abstract class EmployeeDetailEvent extends Equatable {}

class EmployeeDetailInitialLoadEvent extends EmployeeDetailEvent {
  final String employeeId;

  EmployeeDetailInitialLoadEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class DeactivateEmployeeEvent extends EmployeeDetailEvent {
  final String employeeId;

  DeactivateEmployeeEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class EmployeeDisabled extends EmployeeDetailEvent {
  @override
  List<Object?> get props => [];
}
