import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/services/employee_service.dart';
import '../../../../data/provider/user_data.dart';
import '../../../../data/services/space_service.dart';
import 'create_workspace_event.dart';
import 'create_workspace_state.dart';

@Injectable()
class CreateSpaceBLoc extends Bloc<CreateSpaceEvent, CreateSpaceState> {
  final SpaceService _spaceService;
  final EmployeeService _employeeService;
  final UserManager _userManager;

  CreateSpaceBLoc(this._spaceService, this._userManager, this._employeeService)
      : super(CreateSpaceState(ownerName: _userManager.userFirebaseAuthName)) {
    on<PageChangeEvent>(_onPageChange);
    on<CompanyNameChangeEvent>(_onNameChanged);
    on<CompanyDomainChangeEvent>(_onDomainChanged);
    on<PaidTimeOffChangeEvent>(_onTimeOffChanged);
    on<CreateSpaceButtonTapEvent>(_createSpace);
    on<UserNameChangeEvent>(_changeUserName);
  }

  bool validName(String? name) => name != null && name.length >= 4;

  bool validDomain(String? email) =>
      email != null && email.length >= 4 && email.contains('.') ||
          email!.isEmpty;

  void _onPageChange(PageChangeEvent event, Emitter<CreateSpaceState> emit) {
    emit(state.copyWith(buttonState: ButtonState.disable,page: event.page));
    switch (event.page) {
      case 0:
        if (validateFirstStep) {
          emit(state.copyWith(buttonState: ButtonState.enable));
        }
        break;
      case 1:
        if (validateSecondStep) {
          emit(state.copyWith(buttonState: ButtonState.enable));

        }
        break;
      case 2:
        if (validateFirstStep && validateSecondStep && validateThirdStep) {
          emit(state.copyWith(buttonState: ButtonState.enable));
        }
    }
  }


  void _onNameChanged(
      CompanyNameChangeEvent event, Emitter<CreateSpaceState> emit) {
    if (validName(event.companyName)) {
      emit(state.copyWith(
          companyName: event.companyName,
          companyNameError: false,
          buttonState: ButtonState.enable));
    } else {
      emit(state.copyWith(
          companyName: event.companyName,
          companyNameError: true,
          buttonState: ButtonState.disable));
    }
  }

  void _onDomainChanged(
      CompanyDomainChangeEvent event, Emitter<CreateSpaceState> emit) {
    if (validDomain(event.domain)) {
      emit(state.copyWith(domain: event.domain, domainError: false));
    } else {
      emit(state.copyWith(domain: event.domain, domainError: true));
    }
  }

  void _onTimeOffChanged(
      PaidTimeOffChangeEvent event, Emitter<CreateSpaceState> emit) {
    if (event.paidTimeOff == '') {
      emit(state.copyWith(
          paidTimeOff: event.paidTimeOff,
          paidTimeOffError: true,
          buttonState: ButtonState.disable));
    } else {
      emit(state.copyWith(
          paidTimeOff: event.paidTimeOff,
          paidTimeOffError: false,
          buttonState: ButtonState.enable));
    }
  }

  void _changeUserName(UserNameChangeEvent event, Emitter<CreateSpaceState> emit) {
    if (validName(event.name)) {
      emit(state.copyWith(
        buttonState: ButtonState.enable,
        ownerName: event.name,
        ownerNameError: false,
      ));
    } else {
      emit(state.copyWith(
        buttonState: ButtonState.disable,
        ownerName: event.name,
        ownerNameError: true,
      ));
    }
  }

  bool get validateFirstStep =>
      state.companyName.isNotEmpty &&
          validName(state.companyName) &&
          !state.companyNameError &&
          !state.domainError;

  bool get validateSecondStep =>
      (state.paidTimeOff.isNotEmpty) && !state.paidTimeOffError;

  bool get validateThirdStep =>
      validName(state.ownerName) && !state.companyNameError;

  Future<void> _createSpace(
      CreateSpaceButtonTapEvent event, Emitter<CreateSpaceState> emit) async {
    if (validateFirstStep&&validateSecondStep&&validateThirdStep) {
      emit(state.copyWith(createSpaceStatus: CreateSpaceStatus.loading));
      try {
        int timeOff = int.parse(state.paidTimeOff);

        final newSpace = await _spaceService.createSpace(
            name: state.companyName,
            domain: state.domain,
            timeOff: timeOff,
            ownerId: _userManager.userUID!);

        final employee = Employee(
          uid: _userManager.userUID!,
          role: Role.admin,
          name: state.ownerName!,
          email: _userManager.userEmail!,
        );

        await _employeeService.addEmployeeBySpaceId(
            spaceId: newSpace.id, employee: employee);

        emit(state.copyWith(createSpaceStatus: CreateSpaceStatus.success));
        await _userManager.setSpace(space: newSpace, spaceUser: employee);
      } on Exception {
        emit(state.copyWith(
            error: firestoreFetchDataError,
            createSpaceStatus: CreateSpaceStatus.error));
      }
    } else {
      emit(state.copyWith(error: provideRequiredInformation,createSpaceStatus: CreateSpaceStatus.error));
    }
  }
}

