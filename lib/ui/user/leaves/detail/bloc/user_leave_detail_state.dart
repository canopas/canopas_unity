import 'package:equatable/equatable.dart';
import '../../../../../data/model/leave/leave.dart';

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
  final bool showCancelButton;

  UserLeaveDetailSuccessState({
    required this.leave,
    required this.showCancelButton,
  });

  @override
  List<Object?> get props => [leave, showCancelButton];
}

class UserLeaveDetailErrorState extends UserLeaveDetailState {
  final String error;

  UserLeaveDetailErrorState({required this.error});

  @override
  List<Object?> get props => [];
}

class UserCancelLeaveSuccessState extends UserLeaveDetailState {
  @override
  List<Object?> get props => [];
}
