import 'package:equatable/equatable.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/leave/leave.dart';

abstract class UserEmployeeDetailState extends Equatable {}

class UserEmployeeDetailInitialState extends UserEmployeeDetailState {
  @override
  List<Object?> get props => [];
}

class UserEmployeeDetailLoadingState extends UserEmployeeDetailState {
  @override
  List<Object?> get props => [];
}

class UserEmployeeDetailSuccessState extends UserEmployeeDetailState {
  final Employee employee;
  final List<Leave> upcomingLeaves;

  UserEmployeeDetailSuccessState(
      {required this.employee, required this.upcomingLeaves});

  @override
  List<Object?> get props => [employee, upcomingLeaves];
}

class UserEmployeeDetailErrorState extends UserEmployeeDetailState {
  final String error;

  UserEmployeeDetailErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
