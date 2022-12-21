import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class AllLeavesViewState extends Equatable {}

class AllLeavesViewInitialState extends AllLeavesViewState {
  @override
  List<Object?> get props => [];
}

class AllLeavesViewLoadingState extends AllLeavesViewState {
  @override
  List<Object?> get props => [];
}

class AllLeavesViewSuccessState extends AllLeavesViewState {
  final List<LeaveApplication> leaveApplications;

  AllLeavesViewSuccessState({required this.leaveApplications});

  @override
  List<Object?> get props => [leaveApplications];
}

class AllLeavesViewFailureState extends AllLeavesViewState {
  final String error;

  AllLeavesViewFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
