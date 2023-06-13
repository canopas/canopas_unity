import 'package:equatable/equatable.dart';

import '../../../../../data/model/employee/employee.dart';

abstract class UserMembersEvent extends Equatable {}

class UserMemberSuccessEvent extends UserMembersEvent {
  final List<Employee> members;

  UserMemberSuccessEvent(this.members);

  @override
  List<Object?> get props => [members];
}

class UserMemberFailureEvent extends UserMembersEvent {
  final String error;
  UserMemberFailureEvent(this.error);
  @override
  List<Object?> get props => [error];
}

class UserMemberLoadingEvent extends UserMembersEvent {
  @override
  List<Object?> get props => [];
}
