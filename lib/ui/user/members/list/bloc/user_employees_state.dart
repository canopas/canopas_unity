import 'package:equatable/equatable.dart';
import '../../../../../data/model/employee/employee.dart';

abstract class UserEmployeesState extends Equatable {}

class UserEmployeesInitialState extends UserEmployeesState {
  @override
  List<Object?> get props => [];
}

class UserEmployeesLoadingState extends UserEmployeesState {
  @override
  List<Object?> get props => [];
}

class UserEmployeesSuccessState extends UserEmployeesState {
  final List<Employee> employees;

  UserEmployeesSuccessState({required this.employees});

  @override
  List<Object?> get props => [employees];
}

class UserEmployeesFailureState extends UserEmployeesState {
  final String error;

  UserEmployeesFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
