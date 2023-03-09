import 'package:equatable/equatable.dart';

import '../../../../model/leave_application.dart';
import '../../../../model/leave_count.dart';

enum WhoOIsOutCardStatus { initial, loading, success, failure }

class WhoIsOutCardState extends Equatable {
  final WhoOIsOutCardStatus status;
  final DateTime dateOfAbsenceEmployee;
  final List<LeaveApplication> absence;
  final String? error;

  const WhoIsOutCardState(
      { required this.dateOfAbsenceEmployee,
        this.status = WhoOIsOutCardStatus.initial,
      this.absence = const [],
      this.error});

  WhoIsOutCardState copyWith({
    DateTime? dateOfAbsenceEmployee,
    WhoOIsOutCardStatus? status,
      LeaveCounts? leaveCounts,
      List<LeaveApplication>? absence}) {
    return WhoIsOutCardState(
        dateOfAbsenceEmployee: dateOfAbsenceEmployee ?? this.dateOfAbsenceEmployee,
        status: status ?? this.status,
        absence: absence ?? this.absence);
  }



  WhoIsOutCardState failure({required String error}){
    return WhoIsOutCardState(status: WhoOIsOutCardStatus.failure,error: error, dateOfAbsenceEmployee: dateOfAbsenceEmployee);
  }

  @override
  List<Object?> get props => [status, dateOfAbsenceEmployee, absence,error];
}
