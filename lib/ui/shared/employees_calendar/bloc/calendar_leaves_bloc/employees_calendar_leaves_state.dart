import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class EmployeesCalendarLeavesState extends Equatable{}

class EmployeesCalendarLeavesInitialState extends EmployeesCalendarLeavesState{
  @override
  List<Object?> get props => [];
}

class EmployeesCalendarLeavesLoadingState extends EmployeesCalendarLeavesState{
  @override
  List<Object?> get props => [];
}

class EmployeesCalendarLeavesSuccessState extends EmployeesCalendarLeavesState{
  final List<LeaveApplication> leaveApplications;
  EmployeesCalendarLeavesSuccessState({this.leaveApplications = const []});
  @override
  List<Object?> get props => [leaveApplications];
}

class EmployeesCalendarLeavesFailureState extends EmployeesCalendarLeavesState{
  final String error;
  EmployeesCalendarLeavesFailureState(this.error);
  @override
  List<Object?> get props => [error];
}