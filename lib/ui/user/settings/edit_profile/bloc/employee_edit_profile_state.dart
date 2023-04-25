
import 'package:equatable/equatable.dart';

enum EmployeeProfileState { initial, loading, success, failure }

class EmployeeEditProfileState extends Equatable {
  final EmployeeProfileState status;
  final int? gender;
  final DateTime? dateOfBirth;
  final bool nameError;
  final bool designationError;
  final String? error;
  final String? imageURL;

  const EmployeeEditProfileState({
    this.gender,
    this.dateOfBirth,
    this.status = EmployeeProfileState.initial,
    this.error,
    this.nameError = false,
    this.designationError = false,
    this.imageURL,
  });

  copyWith({
    int? gender,
    DateTime? dateOfBirth,
    bool? nameError,
    bool? designationError,
    String? error,
    EmployeeProfileState? status,
    String? imageURL,
  }) {
    return EmployeeEditProfileState(
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        error: error,
        nameError: nameError ?? this.nameError,
        designationError: designationError ?? this.designationError,
        status: status ?? this.status,
        imageURL: imageURL ?? this.imageURL);
  }

  changeDateOfBirth({DateTime? dateOfBirth}) {
    return EmployeeEditProfileState(
      status: status,
      dateOfBirth: dateOfBirth,
      designationError: designationError,
      nameError: nameError,
      error: error,
      gender: gender,
    );
  }

  changeGender({int? gender}) {
    return EmployeeEditProfileState(
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
    imageURL
      ];
}
