import 'package:equatable/equatable.dart';

import '../../../../../model/employee/employee.dart';

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

class EmployeeListLoadedState extends EmployeeListState {
  final List<Employee> employees;

  const EmployeeListLoadedState({required this.employees});

  @override

  List<Object?> get props => [employees];
}

class EmployeeListFailureState extends EmployeeListState {
  final String error;

   const EmployeeListFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
