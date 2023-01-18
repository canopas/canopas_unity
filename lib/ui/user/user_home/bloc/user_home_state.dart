import 'package:equatable/equatable.dart';

import '../../../../model/leave_application.dart';
import '../../../../model/leave_count.dart';

enum UserHomeStatus { initial, loading, success, failure }

class UserHomeState extends Equatable {
  final UserHomeStatus status;
  final DateTime dateOfAbsenceEmployee;
  final List<LeaveApplication> absence;
  final String? error;

  const UserHomeState(
      { required this.dateOfAbsenceEmployee,
        this.status = UserHomeStatus.initial,
      this.absence = const [],
      this.error});

  UserHomeState copyWith({
    DateTime? dateOfAbsenceEmployee,
    UserHomeStatus? status,
      LeaveCounts? leaveCounts,
      List<LeaveApplication>? absence}) {
    return UserHomeState(
        dateOfAbsenceEmployee: dateOfAbsenceEmployee ?? this.dateOfAbsenceEmployee,
        status: status ?? this.status,
        absence: absence ?? this.absence);
  }



  UserHomeState failure({required String error}){
    return UserHomeState(status: UserHomeStatus.failure,error:this.error, dateOfAbsenceEmployee: dateOfAbsenceEmployee);
  }

  @override
  List<Object?> get props => [status, dateOfAbsenceEmployee, absence,error];
}
