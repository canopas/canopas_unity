import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/mixin/input_validation.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/storage_service.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/provider/user_state.dart';
import '../../../../data/services/space_service.dart';
import 'create_workspace_event.dart';
import 'create_workspace_state.dart';

@Injectable()
class CreateSpaceBLoc extends Bloc<CreateSpaceEvent, CreateSpaceState>
    with InputValidationMixin {
  final ImagePicker imagePicker;
  final StorageService storageService;
  final SpaceService _spaceService;
  final EmployeeService _employeeService;
  final UserStateNotifier _userManager;

  CreateSpaceBLoc(this._spaceService, this._userManager, this._employeeService,
      this.imagePicker, this.storageService)
      : super(CreateSpaceState(ownerName: _userManager.userFirebaseAuthName)) {
    on<PageChangeEvent>(_onPageChange);
    on<CompanyNameChangeEvent>(_onNameChanged);
    on<CompanyDomainChangeEvent>(_onDomainChanged);
    on<PaidTimeOffChangeEvent>(_onTimeOffChanged);
    on<CreateSpaceButtonTapEvent>(_createSpace);
    on<UserNameChangeEvent>(_changeUserName);
    on<PickImageEvent>(_pickImage);
  }

  void _onPageChange(PageChangeEvent event, Emitter<CreateSpaceState> emit) {
    emit(state.copyWith(buttonState: ButtonState.disable, page: event.page));
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
    if (validInputLength(event.companyName)) {
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

  void _changeUserName(
      UserNameChangeEvent event, Emitter<CreateSpaceState> emit) {
    if (validInputLength(event.name)) {
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

  Future<void> _pickImage(
      PickImageEvent event, Emitter<CreateSpaceState> emit) async {
    final XFile? image = await imagePicker.pickImage(source: event.imageSource);
    if (image != null) {
      emit(state.copyWith(logo: image.path,isLogoPickedDone: true));
    }
  }

  bool get validateFirstStep =>
      state.companyName.isNotEmpty &&
      validInputLength(state.companyName) &&
      !state.companyNameError &&
      !state.domainError;

  bool get validateSecondStep =>
      (state.paidTimeOff.isNotEmpty) && !state.paidTimeOffError;

  bool get validateThirdStep =>
      validInputLength(state.ownerName) && !state.companyNameError;

  Future<void> _createSpace(
      CreateSpaceButtonTapEvent event, Emitter<CreateSpaceState> emit) async {
    if (validateFirstStep && validateSecondStep && validateThirdStep) {
      emit(state.copyWith(createSpaceStatus: Status.loading));
      String? logoURL;
      try {
        int timeOff = int.parse(state.paidTimeOff);

        if (state.logo != null) {
          final String storagePath =
              'images/${_userManager.currentSpaceId}/space-logo';
          logoURL = await storageService.uploadProfilePic(
              path: storagePath, imagePath: state.logo!);
        }

        final newSpace = await _spaceService.createSpace(
            logo: logoURL,
            name: state.companyName,
            domain: state.domain.isEmpty ? null : state.domain,
            timeOff: timeOff,
            ownerId: _userManager.userUID!);

        final employee = Employee(
          uid: _userManager.userUID!,
          role: Role.admin,
          name: state.ownerName!,
          email: _userManager.userEmail!,
          dateOfJoining: DateTime.now().timeStampToInt,
        );

        await _employeeService.addEmployeeBySpaceId(
            spaceId: newSpace.id, employee: employee);

        emit(state.copyWith(createSpaceStatus: Status.success));
        await _userManager.setEmployeeWithSpace(
            space: newSpace, spaceUser: employee);
      } on Exception {
        emit(state.copyWith(
            error: firestoreFetchDataError, createSpaceStatus: Status.error));
      }
    } else {
      emit(state.copyWith(
          error: provideRequiredInformation, createSpaceStatus: Status.error));
    }
  }
}
