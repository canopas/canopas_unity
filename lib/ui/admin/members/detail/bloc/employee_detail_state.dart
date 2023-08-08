import 'package:equatable/equatable.dart';
import 'package:projectunity/data/model/leave_count.dart';
import '../../../../../data/model/employee/employee.dart';

abstract class AdminEmployeeDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeDetailInitialState extends AdminEmployeeDetailState {}

class EmployeeDetailLoadingState extends AdminEmployeeDetailState {}

class EmployeeDetailLoadedState extends AdminEmployeeDetailState {
  final Employee employee;
  final double timeOffRatio;
  final LeaveCounts usedLeaves;

  EmployeeDetailLoadedState(
      {required this.employee,
      required this.timeOffRatio,
      required this.usedLeaves});

  @override
  List<Object?> get props => [employee, timeOffRatio, usedLeaves];
}

class EmployeeDetailFailureState extends AdminEmployeeDetailState {
  final String error;

  EmployeeDetailFailureState({required this.error});
}
