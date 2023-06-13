import 'package:equatable/equatable.dart';
import '../../../../../data/model/employee/employee.dart';

abstract class UserMembersState extends Equatable {}

class UserMembersInitialState extends UserMembersState {
  @override
  List<Object?> get props => [];
}

class UserMembersLoadingState extends UserMembersState {
  @override
  List<Object?> get props => [];
}

class UserMembersSuccessState extends UserMembersState {
  final List<Employee> employees;

  UserMembersSuccessState({required this.employees});

  @override
  List<Object?> get props => [employees];
}

class UserMembersFailureState extends UserMembersState {
  final String error;

  UserMembersFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
