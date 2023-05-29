import 'package:equatable/equatable.dart';

import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/invitation/invitation.dart';

abstract class EmployeeListState extends Equatable {
  const EmployeeListState();
}

class EmployeeListInitialState extends EmployeeListState {
  @override
  List<Object?> get props => [];
}

class EmployeeListLoadingState extends EmployeeListState {
  @override
  List<Object?> get props => [];
}

class EmployeeListSuccessState extends EmployeeListState {
  final List<Employee> employees;
  final List<Invitation> invitation;

  const EmployeeListSuccessState({required this.employees,required this.invitation});

  @override
  List<Object?> get props => [employees, invitation];
}

class EmployeeListFailureState extends EmployeeListState {
  final String error;

  const EmployeeListFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
