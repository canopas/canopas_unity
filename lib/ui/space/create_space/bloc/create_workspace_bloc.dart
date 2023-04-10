import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/const/role.dart';
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
      : super(const CreateSpaceState()) {
    on<PageChangeEvent>(_onPageChange);
    on<CompanyNameChangeEvent>(_onNameChanged);
    on<CompanyDomainChangeEvent>(_onDomainChanged);
    on<PaidTimeOffChangeEvent>(_onTimeOffChanged);
    on<CreateSpaceButtonTapEvent>(_createSpace);
  }

  bool validName(String? name) => name != null && name.length >= 4;

  bool validDomain(String? email) =>
      email != null && email.length >= 4 && email.contains('.') ||
      email!.isEmpty;

  void _onPageChange(PageChangeEvent event, Emitter<CreateSpaceState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _onNameChanged(
      CompanyNameChangeEvent event, Emitter<CreateSpaceState> emit) {
    if (validName(event.name)) {
      emit(state.copyWith(
          name: event.name,
          nameError: false,
          nextButtonStatus: ButtonStatus.enable));
    } else {
      emit(state.copyWith(
          name: event.name,
          nameError: true,
          nextButtonStatus: ButtonStatus.disable));
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
          createSpaceButtonStatus: ButtonStatus.disable));
    } else {
      emit(state.copyWith(
          paidTimeOff: event.paidTimeOff,
          paidTimeOffError: false,
          createSpaceButtonStatus: ButtonStatus.enable));
    }
  }

  bool get validateSpaceData =>
      validName(state.name) && !state.nameError && !state.domainError;

  Future<void> _createSpace(
      CreateSpaceButtonTapEvent event, Emitter<CreateSpaceState> emit) async {
    if (validateSpaceData) {
      emit(state.copyWith(createSpaceStatus: CreateSpaceStatus.loading));
      try {
        int timeOff = int.parse(state.paidTimeOff);

        final newSpace = await _spaceService.createSpace(
            ownerEmail: _userManager.userEmail!,
            name: state.name,
            domain: state.domain,
            timeOff: timeOff,
            ownerId: _userManager.userUID!);

        final employee = Employee(
            id: _userManager.userUID!,
            roleType: kRoleTypeAdmin,
            name: "unknown",
            employeeId: '1',
            email: _userManager.userEmail!,
            designation: 'unknown');

        await _employeeService.addEmployeeBySpaceId(
            spaceId: newSpace.id, employee: employee);

        emit(state.copyWith(createSpaceStatus: CreateSpaceStatus.success));
        await _userManager.setSpace(space: newSpace, admin: employee);
      } on Exception {
        emit(state.copyWith(
            error: firestoreFetchDataError,
            createSpaceStatus: CreateSpaceStatus.error));
      }
    } else {
      emit(state.copyWith(error: provideRequiredInformation));
    }
  }
}
