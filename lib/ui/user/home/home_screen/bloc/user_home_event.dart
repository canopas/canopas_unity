import 'package:equatable/equatable.dart';

abstract class UserHomeEvent extends Equatable {}

class UserDisabled extends UserHomeEvent {
  final String employeeId;

  UserDisabled(this.employeeId);

  @override
  List<Object?> get props => [employeeId];
}

class UserHomeFetchLeaveRequest extends UserHomeEvent {
  UserHomeFetchLeaveRequest();

  @override
  List<Object?> get props => [];
}
