import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave_application.dart';
import '../../../../../data/model/employee/employee.dart';

class AdminLeavesState extends Equatable {
  final Status status;
  final String? error;
  final List<Employee> members;
  final List<LeaveApplication> leaveApplication;
  final Employee? selectedEmployee;
  final int selectedYear;

  AdminLeavesState(
      {this.status = Status.initial,
      this.error,
      int? selectedYear,
      this.leaveApplication = const [],
      this.members = const [],
      this.selectedEmployee})
      : selectedYear = selectedYear ?? DateTime.now().year;

  copyWith({
    Status? status,
    String? error,
    List<Employee>? members,
    List<LeaveApplication>? leaveApplication,
    Employee? selectedEmployee,
    bool assignSelectedEmployeeNull = false,
    int? selectedYear,
  }) =>
      AdminLeavesState(
        error: error,
        selectedYear: selectedYear ?? this.selectedYear,
        status: status ?? this.status,
        leaveApplication: leaveApplication ?? this.leaveApplication,
        members: members ?? this.members,
        selectedEmployee: selectedEmployee ??
            (assignSelectedEmployeeNull ? null : this.selectedEmployee),
      );

  @override
  List<Object?> get props => [
        status,
        error,
        leaveApplication,
        members,
        selectedYear,
        selectedEmployee
      ];
}
