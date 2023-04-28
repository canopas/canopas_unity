import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave_application.dart';

class AdminHomeState extends Equatable {
  final Status status;
  final Map<DateTime, List<LeaveApplication>> leaveAppMap;
  final String? error;

  const AdminHomeState(
      {this.status = Status.initial, this.leaveAppMap = const {}, this.error});

  AdminHomeState copyWith({
    Status? status,
    Map<DateTime, List<LeaveApplication>>? leaveAppMap,
  }) {
    return AdminHomeState(
      status: status ?? this.status,
      leaveAppMap: leaveAppMap ?? this.leaveAppMap,
    );
  }

  AdminHomeState failureState(
      {Status? status, required String failureMessage}) {
    return AdminHomeState(status: Status.error, error: failureMessage);
  }

  @override
  List<Object?> get props => [status, leaveAppMap, error];
}
