import 'package:equatable/equatable.dart';

enum UserLeaveCountStatus { initial, loading, success, failure }

class UserLeaveCountState extends Equatable {
  final UserLeaveCountStatus? status;
  final int? totalLeaves;
  final double? remaining;
  final double? leavePercentage;
  final String? error;

  const UserLeaveCountState({
    this.status = UserLeaveCountStatus.initial,
    this.remaining = 12,
    this.totalLeaves=12,
    this.leavePercentage = 1,
    this.error=''
  });

  UserLeaveCountState copyWith({ UserLeaveCountStatus? status,
  double? remaining,
    int? totalLeaves,
    String? error,
  double? leavePercentage}) {
    return UserLeaveCountState(status: status ?? this.status,
        remaining: remaining ?? this.remaining,
        totalLeaves: totalLeaves??this.totalLeaves,
        leavePercentage: leavePercentage ?? this.leavePercentage,
      error: error??this.error
    );
  }


  @override
  List<Object?> get props => [status,remaining,leavePercentage];

}