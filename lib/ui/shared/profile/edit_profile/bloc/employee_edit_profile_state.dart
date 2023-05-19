import 'package:equatable/equatable.dart';

import '../../../../../data/core/utils/bloc_status.dart';

class EmployeeEditProfileState extends Equatable {
  final Status status;
  final int? gender;
  final DateTime? dateOfBirth;
  final bool nameError;
  final String? error;
  final String? imageURL;
  final bool isImagePickedDone;

  const EmployeeEditProfileState({
    this.isImagePickedDone = false,
    this.gender,
    this.dateOfBirth,
    this.status = Status.initial,
    this.error,
    this.nameError = false,
    this.imageURL,
  });

  bool get isDataValid => !nameError;

  EmployeeEditProfileState copyWith({
    bool? isImagePickedDone,
    int? gender,
    DateTime? dateOfBirth,
    bool? nameError,
    String? error,
    Status? status,
    String? imageURL,
  }) {
    return EmployeeEditProfileState(
        isImagePickedDone: isImagePickedDone ?? false,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        error: error,
        nameError: nameError ?? this.nameError,
        status: status ?? this.status,
        imageURL: imageURL ?? this.imageURL);
  }

  EmployeeEditProfileState changeDateOfBirth({DateTime? dateOfBirth}) {
    return EmployeeEditProfileState(
      status: status,
      dateOfBirth: dateOfBirth,
      nameError: nameError,
      error: error,
      gender: gender,
      imageURL: imageURL,
    );
  }

  EmployeeEditProfileState changeGender({int? gender}) {
    return EmployeeEditProfileState(
      status: status,
      dateOfBirth: dateOfBirth,
      nameError: nameError,
      error: error,
      gender: gender,
      imageURL: imageURL,
    );
  }

  @override
  List<Object?> get props =>
      [gender, dateOfBirth, status, nameError, error, imageURL];
}
