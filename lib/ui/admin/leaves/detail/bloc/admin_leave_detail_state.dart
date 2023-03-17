import 'package:equatable/equatable.dart';

abstract class AdminLeaveDetailState extends Equatable {}

class AdminLeaveDetailInitialState extends AdminLeaveDetailState {
  @override
  List<Object?> get props => [];
}

class AdminLeaveDetailLoadingState extends AdminLeaveDetailState {
  @override
  List<Object?> get props => [];
}

class AdminLeaveDetailSuccessState extends AdminLeaveDetailState {
  final int paidLeaves;
  final double usedLeaves;

  AdminLeaveDetailSuccessState(
      {required this.usedLeaves, required this.paidLeaves});

  @override
  List<Object?> get props => [usedLeaves, paidLeaves];
}

class AdminLeaveDetailFailureState extends AdminLeaveDetailState {
  final String error;

  AdminLeaveDetailFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class AdminLeaveApplicationResponseSuccessState extends AdminLeaveDetailState {
  @override
  List<Object?> get props => [];
}

class AdminLeaveApplicationDetailResponseLoadingState
    extends AdminLeaveDetailState {
  @override
  List<Object?> get props => [];
}

class DeleteLeaveApplicationSuccessState extends AdminLeaveDetailState {
  @override
  List<Object?> get props => [];
}

class DeleteLeaveApplicationLoadingState extends AdminLeaveDetailState {
  @override
  List<Object?> get props => [];
}
