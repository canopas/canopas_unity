import 'package:equatable/equatable.dart';
import 'package:projectunity/model/employee/employee.dart';

abstract class AdminEmployeesState extends Equatable {}

class AdminEmployeesInitialState extends AdminEmployeesState {
  @override
  List<Object?> get props => [];
}

class AdminEmployeesLoadingState extends AdminEmployeesState {
  @override
  List<Object?> get props => [];
}

class AdminEmployeesSuccessState extends AdminEmployeesState {
  final List<Employee> employees;

  AdminEmployeesSuccessState({required this.employees});

  @override
  List<Object?> get props => [employees];
}

class AdminEmployeesFailureState extends AdminEmployeesState {
  final String error;

  AdminEmployeesFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
