import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/leave/leave.dart';

class AdminLeavesState extends Equatable {
  final Status status;
  final String? error;
  final List<Employee> employees;
  final List<Leave> leaves;
  final Employee? selectedEmployee;
  final String searchEmployeeInput;
  final int selectedYear;

  AdminLeavesState(
      {this.searchEmployeeInput = '',
      this.status = Status.initial,
      this.error,
      int? selectedYear,
      this.leaves = const [],
      this.employees = const [],
      this.selectedEmployee})
      : selectedYear = selectedYear ?? DateTime.now().year;

  copyWith({
    String? searchEmployeeInput,
    Status? status,
    String? error,
    List<Employee>? employees,
    List<Leave>? leaves,
    Employee? selectedEmployee,
    bool assignSelectedEmployeeNull = false,
    int? selectedYear,
  }) =>
      AdminLeavesState(
        searchEmployeeInput: searchEmployeeInput ?? this.searchEmployeeInput,
        error: error,
        selectedYear: selectedYear ?? this.selectedYear,
        status: status ?? this.status,
        leaves: leaves ?? this.leaves,
        employees: employees ?? this.employees,
        selectedEmployee: selectedEmployee ??
            (assignSelectedEmployeeNull ? null : this.selectedEmployee),
      );

  @override
  List<Object?> get props => [
        status,
        error,
        leaves,
        employees,
        selectedYear,
        selectedEmployee,
        searchEmployeeInput
      ];
}
