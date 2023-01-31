import 'package:equatable/equatable.dart';

import '../../../../../model/leave/leave.dart';

abstract class UserLeaveState extends Equatable {}

class UserLeaveInitialState extends UserLeaveState {
  @override
  List<Object?> get props => [];
}

class UserLeaveLoadingState extends UserLeaveState {
  @override
  List<Object?> get props => [];
}

class UserLeaveSuccessState extends UserLeaveState {
  final List<Leave> pastLeaves;
  final List<Leave> upcomingLeaves;

  UserLeaveSuccessState({required this.pastLeaves,required this.upcomingLeaves});

  @override
  List<Object?> get props => [pastLeaves,upcomingLeaves];
}

class UserLeaveErrorState extends UserLeaveState {
  final String error;

  UserLeaveErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
