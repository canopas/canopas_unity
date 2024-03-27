import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';

class AdminEditEmployeeDetailsState extends Equatable {
  final Status status;
  final Role role;
  final DateTime? dateOfJoining;
  final DateTime? dateOfBirth;

  final String? error;
  final String? pickedImage;
  final bool nameError;
  final bool designationError;
  final bool employeeIdError;
  final bool emailError;

  const AdminEditEmployeeDetailsState({
    this.pickedImage,
    this.dateOfJoining,
    this.dateOfBirth,
    this.nameError = false,
    this.emailError = false,
    this.employeeIdError = false,
    this.designationError = false,
    this.error,
    this.status = Status.initial,
    this.role = Role.employee,
  });

  bool get isValid =>
      nameError == false &&
      emailError == false &&
      employeeIdError == false &&
      designationError == false;

  copyWith({
    String? error,
    bool? nameError,
    bool? designationError,
    bool? employeeIdError,
    bool? emailError,
    DateTime? dateOfJoining,
    DateTime? dateOfBirth,
    String? pickedImage,
    Role? role,
    Status? status,
  }) {
    return AdminEditEmployeeDetailsState(
      pickedImage: pickedImage ?? this.pickedImage,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      designationError: designationError ?? this.designationError,
      emailError: emailError ?? this.emailError,
      employeeIdError: employeeIdError ?? this.employeeIdError,
      nameError: nameError ?? this.nameError,
      error: error,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        pickedImage,
        status,
        role,
        error,
        dateOfJoining,
        nameError,
        emailError,
        designationError,
        employeeIdError
      ];
}
