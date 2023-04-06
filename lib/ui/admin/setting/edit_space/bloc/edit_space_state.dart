import 'package:equatable/equatable.dart';

enum Status { initial, loading, failure, success }

class EditSpaceState extends Equatable {
  final Status fetchDataStatus;
  final Status deleteWorkSpaceStatus;
  final String? error;
  final bool nameIsValid;
  final bool yearlyPaidTimeOffIsValid;

  const EditSpaceState(
      {this.fetchDataStatus = Status.initial,
      this.deleteWorkSpaceStatus = Status.initial,
      this.error,
      this.nameIsValid = true,
      this.yearlyPaidTimeOffIsValid = true});

  copyWith(
          {String? error,
          Status? fetchDataStatus,
          Status? deleteWorkSpaceStatus,
          bool? nameIsValid,
          bool? yearlyPaidTimeOffIsValid}) =>
      EditSpaceState(
          error: error,
          fetchDataStatus: fetchDataStatus ?? this.fetchDataStatus,
          deleteWorkSpaceStatus:
              deleteWorkSpaceStatus ?? this.deleteWorkSpaceStatus,
          nameIsValid: nameIsValid ?? this.nameIsValid,
          yearlyPaidTimeOffIsValid:
              yearlyPaidTimeOffIsValid ?? this.yearlyPaidTimeOffIsValid);

  bool get isValid => nameIsValid && yearlyPaidTimeOffIsValid;

  @override
  List<Object?> get props => [
        deleteWorkSpaceStatus,
        fetchDataStatus,
        error,
        nameIsValid,
        yearlyPaidTimeOffIsValid
      ];
}
