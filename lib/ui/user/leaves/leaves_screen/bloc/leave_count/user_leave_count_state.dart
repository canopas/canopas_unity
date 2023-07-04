import 'package:equatable/equatable.dart';
import '../../../../../../data/core/utils/bloc_status.dart';

class UserLeaveCountState extends Equatable {
  final Status status;
  final double used;
  final double leavePercentage;
  final String? error;

  const UserLeaveCountState(
      {this.status = Status.initial,
      this.used = 0,
      this.leavePercentage = 0,
      this.error});

  UserLeaveCountState copyWith(
      {Status? status,
      double? used,
      String? error,
      double? leavePercentage}) {
    return UserLeaveCountState(
        status: status ?? this.status,
        used: used ?? this.used,
        leavePercentage: leavePercentage ?? this.leavePercentage,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props =>
      [status, used, leavePercentage, error];
}
