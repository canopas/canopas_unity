import 'package:equatable/equatable.dart';

enum AdminEditEmployeeDetailsStatus { initial, loading, success, failure }

class AdminEditEmployeeDetailsState extends Equatable {
  final AdminEditEmployeeDetailsStatus adminEditEmployeeDetailsStatus;
  final int roleType;
  final DateTime? dateOfJoining;
  final String? error;
  final bool nameError;
  final bool designationError;
  final bool employeeIdError;
  final bool emailError;

  const AdminEditEmployeeDetailsState({
    this.dateOfJoining,
    this.nameError = false,
    this.emailError = false,
    this.employeeIdError = false,
    this.designationError = false,
    this.error,
    this.adminEditEmployeeDetailsStatus =
        AdminEditEmployeeDetailsStatus.initial,
    this.roleType = 2,
  });

  bool get isValid => nameError == false && emailError == false && employeeIdError == false && designationError == false;

  copyWith({
    String? error,
    bool? nameError,
    bool? designationError,
    bool? employeeIdError,
    bool? emailError,
    DateTime? dateOfJoining,
    int? roleType,
    AdminEditEmployeeDetailsStatus? adminEditEmployeeDetailsStatus,
  }) {
    return AdminEditEmployeeDetailsState(
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      designationError: designationError ?? this.designationError,
      emailError: emailError ?? this.emailError,
      employeeIdError: employeeIdError ?? this.employeeIdError,
      nameError: nameError ?? this.nameError,
      error: error,
      roleType: roleType ?? this.roleType,
      adminEditEmployeeDetailsStatus:
          adminEditEmployeeDetailsStatus ?? this.adminEditEmployeeDetailsStatus,
    );
  }


  @override
  List<Object?> get props => [
        adminEditEmployeeDetailsStatus,
        roleType,
        error,
        dateOfJoining,
        nameError,
        emailError,
        designationError,
        employeeIdError
      ];
}
