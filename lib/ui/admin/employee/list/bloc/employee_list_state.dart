import 'package:equatable/equatable.dart';

import '../../../../../model/employee/employee.dart';

abstract class EmployeeListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeListInitialState extends EmployeeListState {}

class EmployeeListLoadingState extends EmployeeListState {}

class EmployeeListLoadedState extends EmployeeListState {
  final List<Employee> employees;

  EmployeeListLoadedState({required this.employees});

  @override
  List<Object?> get props => [employees];
}

class EmployeeListFailureState extends EmployeeListState {
  final String error;

   EmployeeListFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
