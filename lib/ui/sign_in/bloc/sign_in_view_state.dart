import 'package:equatable/equatable.dart';
import 'package:projectunity/data/model/employee/employee.dart';

abstract class SignInState extends Equatable {}

class SignInInitialState extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInLoadingState extends SignInState {
  @override
  List<Object?> get props => [];
}


class SignInScreenFailureState extends SignInState {
  final String error;

  SignInScreenFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignInSuccessState extends SignInState {
  @override
  List<Object?> get props => [];
}

class CreateSpaceSignInSuccessState extends SignInState {
  final Employee employee;
  CreateSpaceSignInSuccessState(this.employee);
  @override
  List<Object?> get props => [employee];
}
