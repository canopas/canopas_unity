import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class WhoIsOutViewState extends Equatable{}

class WhoIsOutViewInitialState extends WhoIsOutViewState{
  @override
  List<Object?> get props => [];
}

class WhoISOutViewLoadingState extends WhoIsOutViewState{
  @override
  List<Object?> get props => [];
}

class WhoIsOutViewSuccessState extends WhoIsOutViewState{
  final List<LeaveApplication> leaveApplications;
  WhoIsOutViewSuccessState({this.leaveApplications = const []});
  @override
  List<Object?> get props => [leaveApplications];
}

class WhoIsOutViewFailureState extends WhoIsOutViewState{
  final String error;
  WhoIsOutViewFailureState(this.error);
  @override
  List<Object?> get props => [error];
}