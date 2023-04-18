import 'package:equatable/equatable.dart';

enum Status { initial, loading, failure, success }

class EditSpaceState extends Equatable {
  final Status deleteWorkSpaceStatus;
  final Status updateSpaceStatus;
  final String? error;
  final bool nameIsValid;
  final bool yearlyPaidTimeOffIsValid;

  const EditSpaceState(
      {this.deleteWorkSpaceStatus = Status.initial,
      this.updateSpaceStatus = Status.initial,
      this.error,
      this.nameIsValid = true,
      this.yearlyPaidTimeOffIsValid = true});

  copyWith(
          {String? error,
          Status? deleteWorkSpaceStatus,
          Status? updateSpaceStatus,
          bool? nameIsValid,
          bool? yearlyPaidTimeOffIsValid}) =>
      EditSpaceState(
          error: error,
          updateSpaceStatus: updateSpaceStatus ?? this.updateSpaceStatus,
          deleteWorkSpaceStatus:
              deleteWorkSpaceStatus ?? this.deleteWorkSpaceStatus,
          nameIsValid: nameIsValid ?? this.nameIsValid,
          yearlyPaidTimeOffIsValid:
              yearlyPaidTimeOffIsValid ?? this.yearlyPaidTimeOffIsValid);

  bool get isDataValid => nameIsValid && yearlyPaidTimeOffIsValid;

  bool get isFailure =>
      (updateSpaceStatus != Status.failure ||
          deleteWorkSpaceStatus != Status.failure) &&
      error != null;

  @override
  List<Object?> get props => [
        updateSpaceStatus,
        deleteWorkSpaceStatus,
        error,
        nameIsValid,
        yearlyPaidTimeOffIsValid
      ];
}
