import 'package:equatable/equatable.dart';
import '../../../../data/core/utils/bloc_status.dart';

enum ButtonState { enable, disable }

class CreateSpaceState extends Equatable {
  final String companyName;
  final int page;
  final String domain;
  final String? logo;
  final bool isLogoPickedDone;
  final bool companyNameError;
  final bool domainError;
  final String paidTimeOff;
  final bool paidTimeOffError;
  final ButtonState buttonState;
  final String? error;
  final Status createSpaceStatus;
  final String? ownerName;
  final bool ownerNameError;

  const CreateSpaceState(
      {this.isLogoPickedDone = false,
      this.logo,
      this.page = 0,
      this.companyName = '',
      this.domain = '',
      this.companyNameError = false,
      this.domainError = false,
      this.paidTimeOff = '',
      this.paidTimeOffError = false,
      this.buttonState = ButtonState.disable,
      this.createSpaceStatus = Status.initial,
      this.ownerName,
      this.ownerNameError = false,
      this.error = ''});

  CreateSpaceState copyWith({
    bool? isLogoPickedDone,
    String? logo,
    int? page,
    String? companyName,
    String? domain,
    bool? companyNameError,
    bool? domainError,
    String? paidTimeOff,
    bool? paidTimeOffError,
    ButtonState? buttonState,
    String? error,
    String? ownerName,
    bool? ownerNameError,
    Status? createSpaceStatus,
  }) =>
      CreateSpaceState(
          isLogoPickedDone: isLogoPickedDone ?? false,
          logo: logo ?? this.logo,
          page: page ?? this.page,
          companyName: companyName ?? this.companyName,
          domain: domain ?? this.domain,
          companyNameError: companyNameError ?? this.companyNameError,
          domainError: domainError ?? this.domainError,
          paidTimeOff: paidTimeOff ?? this.paidTimeOff,
          paidTimeOffError: paidTimeOffError ?? this.paidTimeOffError,
          buttonState: buttonState ?? this.buttonState,
          createSpaceStatus: createSpaceStatus ?? Status.initial,
          ownerName: ownerName ?? this.ownerName,
          ownerNameError: ownerNameError ?? this.ownerNameError,
          error: error ?? this.error);

  @override
  List<Object?> get props => [
        logo,
        isLogoPickedDone,
        page,
        companyName,
        domain,
        companyNameError,
        domainError,
        paidTimeOff,
        paidTimeOffError,
        buttonState,
        ownerNameError,
        error,
        createSpaceStatus,
        ownerName,
      ];
}
