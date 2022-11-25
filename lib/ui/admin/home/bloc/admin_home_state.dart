import 'package:equatable/equatable.dart';

import '../../../../model/leave_application.dart';

enum AdminHomeStatus { initial, loading, success, failure }

class AdminHomeState extends Equatable {
  final AdminHomeStatus status;
  final Map<DateTime, List<LeaveApplication>> leaveAppMap;
  final int totalOfEmployees;
  final int totalOfRequests;
  final int totalAbsence;
  final String? error;

  const AdminHomeState( {
    this.status = AdminHomeStatus.initial,
    this.leaveAppMap = const {},
    this.totalOfEmployees = 0,
    this.totalOfRequests = 0,
    this.totalAbsence = 0,
    this.error
  });
  AdminHomeState copyWith({
    AdminHomeStatus? status,
     Map<DateTime, List<LeaveApplication>>? leaveAppMap,
     int? totalOfEmployees,
     int? totalOfRequests,
     int? totalAbsence,
  }){
    return AdminHomeState(
      status: status??this.status,
      leaveAppMap: leaveAppMap??this.leaveAppMap,
      totalOfEmployees: totalOfEmployees??this.totalOfEmployees,
      totalOfRequests: totalOfRequests??this.totalOfRequests,
      totalAbsence: totalAbsence??this.totalAbsence,
    );
  }

  AdminHomeState failureState(
      {AdminHomeStatus? status, required String failureMessage}) {
    return AdminHomeState(
        status: AdminHomeStatus.failure, error: this.error);
  }

  @override
  List<Object?> get props => [status,leaveAppMap,totalOfEmployees,totalOfRequests,totalAbsence];
}


