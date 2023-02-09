import 'package:equatable/equatable.dart';

import '../../../../../model/leave/leave.dart';

abstract class UserLeaveDetailState extends Equatable {}

class UserLeaveDetailInitialState extends UserLeaveDetailState {
  @override
  List<Object?> get props => [];
}

class UserLeaveDetailLoadingState extends UserLeaveDetailState {
  @override
  List<Object?> get props => [];
}

class UserLeaveDetailSuccessState extends UserLeaveDetailState {
  final Leave leave;
  UserLeaveDetailSuccessState({required this.leave});
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserLeaveDetailErrorState extends UserLeaveDetailState {
  final String error;
  UserLeaveDetailErrorState({required this.error});
  @override
  List<Object?> get props => [];
}
