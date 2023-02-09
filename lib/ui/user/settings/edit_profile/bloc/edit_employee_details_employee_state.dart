import 'package:equatable/equatable.dart';

enum EmployeeEditEmployeeDetailsStatus { initial, loading, success, failure }

class EmployeeEditEmployeeDetailsState extends Equatable {
  final EmployeeEditEmployeeDetailsStatus status;
  final int? gender;
  final DateTime? dateOfBirth;
  final bool nameError;
  final bool designationError;
  final String? error;

  const EmployeeEditEmployeeDetailsState({
    this.gender,
    this.dateOfBirth,
    this.status = EmployeeEditEmployeeDetailsStatus.initial,
    this.error,
    this.nameError = false,
    this.designationError = false,
  });

  copyWith({
    int? gender,
    DateTime? dateOfBirth,
    bool? nameError,
    bool? designationError,
    String? error,
    EmployeeEditEmployeeDetailsStatus? status,
  }) {
    return EmployeeEditEmployeeDetailsState(
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      error: error,
      nameError: nameError ?? this.nameError,
      designationError: designationError ?? this.designationError,
      status: status ?? this.status,
    );
  }

  changeDateOfBirth({DateTime? dateOfBirth}) {
    return EmployeeEditEmployeeDetailsState(
      status: status,
      dateOfBirth: dateOfBirth,
      designationError: designationError,
      nameError: nameError,
      error: error,
      gender: gender,
    );
  }

  changeGender({int? gender}) {
    return EmployeeEditEmployeeDetailsState(
      status: status,
      dateOfBirth: dateOfBirth,
      designationError: designationError,
      nameError: nameError,
      error: error,
      gender: gender,
    );
  }

  @override
  List<Object?> get props => [
        gender,
        dateOfBirth,
        status,
        nameError,
        designationError,
        error,
      ];
}
