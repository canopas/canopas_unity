import 'package:equatable/equatable.dart';

enum ButtonStatus { enable, disable }

enum CreateSpaceStatus { initial, loading, error, success }

class CreateSpaceState extends Equatable {
  final int page;
  final String name;
  final String domain;
  final bool nameError;
  final bool domainError;
  final String paidTimeOff;
  final bool paidTimeOffError;
  final ButtonStatus nextButtonStatus;
  final ButtonStatus createSpaceButtonStatus;
  final String? error;

  final CreateSpaceStatus createSpaceStatus;

  const CreateSpaceState(
      {this.page = 0,
      this.name = '',
      this.domain = '',
      this.nameError = false,
      this.domainError = false,
      this.paidTimeOff = '',
      this.paidTimeOffError = false,
      this.nextButtonStatus = ButtonStatus.disable,
      this.createSpaceButtonStatus = ButtonStatus.disable,
      this.createSpaceStatus = CreateSpaceStatus.initial,
      this.error = ''});

  CreateSpaceState copyWith({
    int? page,
    String? name,
    String? domain,
    bool? nameError,
    bool? domainError,
    String? paidTimeOff,
    bool? paidTimeOffError,
    ButtonStatus? nextButtonStatus,
    ButtonStatus? createSpaceButtonStatus,
    String? error,
    CreateSpaceStatus? createSpaceStatus,
  }) =>
      CreateSpaceState(
          page: page ?? this.page,
          name: name ?? this.name,
          domain: domain ?? this.domain,
          nameError: nameError ?? this.nameError,
          domainError: domainError ?? this.domainError,
          paidTimeOff: paidTimeOff ?? this.paidTimeOff,
          paidTimeOffError: paidTimeOffError ?? this.paidTimeOffError,
          nextButtonStatus: nextButtonStatus ?? this.nextButtonStatus,
          createSpaceButtonStatus:
              createSpaceButtonStatus ?? this.createSpaceButtonStatus,
          createSpaceStatus: createSpaceStatus ?? this.createSpaceStatus,
          error: error ?? this.error);

  @override
  List<Object?> get props => [
        page,
        name,
        domain,
        nameError,
        domainError,
        paidTimeOff,
        paidTimeOffError,
        nextButtonStatus,
        createSpaceButtonStatus,
        error
      ];
}
