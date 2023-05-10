import 'package:equatable/equatable.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/model/leave/leave.dart';

class UserLeaveState extends Equatable {
  final List<Leave> leaves;
  final String? error;
  final Status status;

  const UserLeaveState({
    this.leaves = const [],
    this.status = Status.initial,
    this.error
  });

  UserLeaveState copyWith({
    List<Leave>? leaves,
    String? error,
    Status? status,
  }) =>
      UserLeaveState(
        status: status ?? this.status,
        leaves: leaves ?? this.leaves,
        error: error,
      );

  @override
  List<Object?> get props => [leaves, error, status];

}

