import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave_application.dart';
import '../../../../../data/model/employee/employee.dart';

class AdminLeavesState extends Equatable {
  final Status status;
  final String? error;
  final List<Employee> employees;
  final List<LeaveApplication> leaveApplication;
  final Employee? selectedEmployee;
  final String searchEmployeeInput;
  final int selectedYear;

  AdminLeavesState(
      {this.searchEmployeeInput = '',
      this.status = Status.initial,
      this.error,
      int? selectedYear,
      this.leaveApplication = const [],
      this.employees = const [],
      this.selectedEmployee})
      : selectedYear = selectedYear ?? DateTime.now().year;

  copyWith({
    String? searchEmployeeInput,
    Status? status,
    String? error,
    List<Employee>? employees,
    List<LeaveApplication>? leaveApplication,
    Employee? selectedEmployee,
    bool assignSelectedEmployeeNull = false,
    int? selectedYear,
  }) =>
      AdminLeavesState(
        searchEmployeeInput: searchEmployeeInput ?? this.searchEmployeeInput,
        error: error,
        selectedYear: selectedYear ?? this.selectedYear,
        status: status ?? this.status,
        leaveApplication: leaveApplication ?? this.leaveApplication,
        employees: employees ?? this.employees,
        selectedEmployee: selectedEmployee ??
            (assignSelectedEmployeeNull ? null : this.selectedEmployee),
      );

  @override
  List<Object?> get props => [
        status,
        error,
        leaveApplication,
        employees,
        selectedYear,
        selectedEmployee,
        searchEmployeeInput
      ];
}
