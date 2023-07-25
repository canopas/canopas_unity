import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class UserErrorState extends UserState {
  final String error;

  UserErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

class UserInitialState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserRevokeAccessState extends UserState {
  @override
  List<Object?> get props => [];
}
