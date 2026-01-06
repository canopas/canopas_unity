import 'package:equatable/equatable.dart';

class LeaveCounts extends Equatable {
  final double totalUsedLeave;
  final double urgentLeaves;
  final double casualLeaves;

  const LeaveCounts({this.casualLeaves = 0.0, this.urgentLeaves = 0.0})
    : totalUsedLeave = urgentLeaves + casualLeaves;

  @override
  List<Object?> get props => [totalUsedLeave, urgentLeaves, casualLeaves];
}
