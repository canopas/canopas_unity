import 'package:equatable/equatable.dart';

import '../../../../../model/employee/employee.dart';

abstract class AdminEmployeeDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeDetailInitialState extends AdminEmployeeDetailState {}

class EmployeeDetailLoadingState extends AdminEmployeeDetailState {}

class EmployeeDetailLoadedState extends AdminEmployeeDetailState {
  final Employee employee;
  EmployeeDetailLoadedState({required this.employee});
  @override
  List<Object?> get props => [employee];

}

class EmployeeDetailFailureState extends AdminEmployeeDetailState {
  final String error;

  EmployeeDetailFailureState({required this.error});
}
