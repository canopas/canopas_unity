import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../data/model/leave_application.dart';
import '../../../../data/model/leave_count.dart';


class WhoIsOutCardState extends Equatable {
  final Status status;
  final DateTime dateOfAbsenceEmployee;
  final List<LeaveApplication> absence;
  final String? error;

  const WhoIsOutCardState(
      {required this.dateOfAbsenceEmployee,
      this.status = Status.initial,
      this.absence = const [],
      this.error});

  WhoIsOutCardState copyWith(
      {DateTime? dateOfAbsenceEmployee,
      Status? status,
      LeaveCounts? leaveCounts,
      String? error,
      List<LeaveApplication>? absence}) {
    return WhoIsOutCardState(
        dateOfAbsenceEmployee:
            dateOfAbsenceEmployee ?? this.dateOfAbsenceEmployee,
        status: status ?? this.status,
        error: error ?? this.error,
        absence: absence ?? this.absence);
  }


  @override
  List<Object?> get props => [status, dateOfAbsenceEmployee, absence,error];
}
