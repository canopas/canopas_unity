import 'package:equatable/equatable.dart';

import '../../../../../model/leave/leave.dart';

abstract class UserHomeState extends Equatable {}

class UserHomeInitialState extends UserHomeState {
  @override
  List<Object?> get props => [];
}

class UserHomeLoadingState extends UserHomeState {
  @override
  List<Object?> get props => [];
}

class UserHomeSuccessState extends UserHomeState {
  final List<Leave> requests;
  UserHomeSuccessState({required this.requests});
  @override
  List<Object?> get props => [requests];
}

class UserHomeErrorState extends UserHomeState {
  final String error;
  UserHomeErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
