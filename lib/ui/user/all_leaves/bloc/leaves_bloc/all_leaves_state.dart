import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class AllLeavesState extends Equatable {}

class AllLeavesInitialState extends AllLeavesState {
  @override
  List<Object?> get props => [];
}

class AllLeavesLoadingState extends AllLeavesState {
  @override
  List<Object?> get props => [];
}

class AllLeavesSuccessState extends AllLeavesState {
  final List<LeaveApplication> leaveApplications;

  AllLeavesSuccessState({required this.leaveApplications});

  @override
  List<Object?> get props => [leaveApplications];
}

class AllLeavesFailureState extends AllLeavesState {
  final String error;

  AllLeavesFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
