import 'package:equatable/equatable.dart';

class LeaveCounts extends Equatable {
  final double remainingLeaveCount;
  final double usedLeaveCount;
  final int paidLeaveCount;

  const LeaveCounts(
      {this.remainingLeaveCount = 0.0,
      this.usedLeaveCount = 0.0,
      this.paidLeaveCount = 0});

  @override
  List<Object?> get props =>
      [remainingLeaveCount, usedLeaveCount, paidLeaveCount];
}
