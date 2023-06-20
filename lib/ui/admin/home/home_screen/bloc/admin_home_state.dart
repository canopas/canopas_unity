import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave_application.dart';

class AdminHomeState extends Equatable {
  final Status status;
  final Map<DateTime, List<LeaveApplication>> leaveAppMap;
  final String? error;

  const AdminHomeState(
      {this.status = Status.loading, this.leaveAppMap = const {}, this.error});

  AdminHomeState copyWith({
    String? error,
    Status? status,
    Map<DateTime, List<LeaveApplication>>? leaveAppMap,
  }) {
    return AdminHomeState(
      error: error,
      status: status ?? this.status,
      leaveAppMap: leaveAppMap ?? this.leaveAppMap,
    );
  }

  @override
  List<Object?> get props => [status, leaveAppMap, error];
}
