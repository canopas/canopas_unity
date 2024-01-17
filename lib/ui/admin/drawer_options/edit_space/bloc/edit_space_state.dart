import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';

class EditSpaceState extends Equatable {
  final Status deleteWorkSpaceStatus;
  final Status updateSpaceStatus;
  final String? logo;
  final bool isLogoPickedDone;
  final String? error;
  final bool nameIsValid;
  final bool notificationEmailIsValid;
  final bool yearlyPaidTimeOffIsValid;

  const EditSpaceState(
      {this.logo,
      this.notificationEmailIsValid = true,
      this.isLogoPickedDone = false,
      this.deleteWorkSpaceStatus = Status.initial,
      this.updateSpaceStatus = Status.initial,
      this.error,
      this.nameIsValid = true,
      this.yearlyPaidTimeOffIsValid = true});

  copyWith(
          {String? logo,
          bool? isLogoPickedDone,
          String? error,
          Status? deleteWorkSpaceStatus,
          Status? updateSpaceStatus,
          bool? nameIsValid,
          bool? notificationEmailIsValid,
          bool? yearlyPaidTimeOffIsValid}) =>
      EditSpaceState(
          notificationEmailIsValid:
              notificationEmailIsValid ?? this.notificationEmailIsValid,
          logo: logo ?? this.logo,
          isLogoPickedDone: isLogoPickedDone ?? false,
          error: error,
          updateSpaceStatus: updateSpaceStatus ?? this.updateSpaceStatus,
          deleteWorkSpaceStatus:
              deleteWorkSpaceStatus ?? this.deleteWorkSpaceStatus,
          nameIsValid: nameIsValid ?? this.nameIsValid,
          yearlyPaidTimeOffIsValid:
              yearlyPaidTimeOffIsValid ?? this.yearlyPaidTimeOffIsValid);

  bool get isDataValid =>
      nameIsValid && yearlyPaidTimeOffIsValid && notificationEmailIsValid;

  bool get isFailure =>
      (updateSpaceStatus != Status.error ||
          deleteWorkSpaceStatus != Status.error) &&
      error != null;

  @override
  List<Object?> get props => [
        notificationEmailIsValid,
        logo,
        isLogoPickedDone,
        updateSpaceStatus,
        deleteWorkSpaceStatus,
        error,
        nameIsValid,
        yearlyPaidTimeOffIsValid
      ];
}
