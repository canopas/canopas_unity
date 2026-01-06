import 'package:equatable/equatable.dart';

import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';

class EmployeeEditProfileState extends Equatable {
  final Status status;
  final Gender? gender;
  final DateTime? dateOfBirth;
  final bool nameError;
  final bool numberError;
  final String? error;
  final String? imageURL;

  const EmployeeEditProfileState({
    this.gender,
    this.dateOfBirth,
    this.status = Status.initial,
    this.error,
    this.nameError = false,
    this.numberError = false,
    this.imageURL,
  });

  bool get isDataValid => !nameError && !numberError;

  EmployeeEditProfileState copyWith({
    Gender? gender,
    DateTime? dateOfBirth,
    bool? nameError,
    bool? numberError,
    String? error,
    Status? status,
    String? imageURL,
  }) {
    return EmployeeEditProfileState(
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      error: error,
      nameError: nameError ?? this.nameError,
      numberError: numberError ?? this.numberError,
      status: status ?? this.status,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  EmployeeEditProfileState changeDateOfBirth({DateTime? dateOfBirth}) {
    return EmployeeEditProfileState(
      status: status,
      dateOfBirth: dateOfBirth,
      nameError: nameError,
      numberError: numberError,
      error: error,
      gender: gender,
      imageURL: imageURL,
    );
  }

  EmployeeEditProfileState changeGender({Gender? gender}) {
    return EmployeeEditProfileState(
      status: status,
      dateOfBirth: dateOfBirth,
      nameError: nameError,
      numberError: numberError,
      error: error,
      gender: gender,
      imageURL: imageURL,
    );
  }

  @override
  List<Object?> get props => [
    gender,
    dateOfBirth,
    status,
    nameError,
    numberError,
    error,
    imageURL,
  ];
}
