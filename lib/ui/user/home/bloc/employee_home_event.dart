import 'package:equatable/equatable.dart';

abstract class EmployeeHomeEvent extends Equatable {}

class EmployeeHomeFetchEvent extends EmployeeHomeEvent {
  @override

  List<Object?> get props => [];
}

class UserDisabled extends EmployeeHomeEvent{
  final String employeeId;
  UserDisabled(this.employeeId);

  @override
  List<Object?> get props => [employeeId];
}

