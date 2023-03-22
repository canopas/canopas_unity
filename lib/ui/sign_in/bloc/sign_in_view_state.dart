import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {}

class SignInInitialState extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInLoadingState extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInFailureState extends SignInState {
  final String error;

  SignInFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignInSuccessState extends SignInState {
  @override
  List<Object?> get props => [];
}
