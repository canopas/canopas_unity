import 'package:equatable/equatable.dart';

abstract class LogOutState extends Equatable {

}

class LogOutInitialState extends LogOutState {
  @override
  List<Object?> get props => [];
}

class LogOutLoadingState extends LogOutState {
  @override
  List<Object?> get props => [];
}

class LogOutFailureState extends LogOutState {
  final String error;
  LogOutFailureState({required this.error});
  @override
  List<Object?> get props => [error];
}

class LogOutSuccessState extends LogOutState {
  @override
  List<Object?> get props => [];
}


