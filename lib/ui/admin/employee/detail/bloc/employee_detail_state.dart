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
  final double timeOffRatio;
  final int paidLeaves;
  final double usedLeaves;
  EmployeeDetailLoadedState(
      {required this.employee,
      required this.timeOffRatio,
      required this.paidLeaves,
      required this.usedLeaves});
  @override
  List<Object?> get props => [employee, timeOffRatio, paidLeaves, usedLeaves];
}

class EmployeeDetailFailureState extends AdminEmployeeDetailState {
  final String error;

  EmployeeDetailFailureState({required this.error});
}
