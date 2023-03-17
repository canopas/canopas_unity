import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/pref/user_preference.dart';
import '../../../../../data/provider/user_data.dart';
import '../../../../../data/services/employee_service.dart';
import '../../settings_screen/bloc/user_settings_event.dart';
import 'employee_edit_profile_event.dart';
import 'employee_edit_profile_state.dart';

@Injectable()
class EmployeeEditProfileBloc
    extends Bloc<EditProfileEvent, EmployeeEditProfileState> {
  final EmployeeService _employeeService;
  final UserManager _userManager;
  final UserPreference _preference;

  EmployeeEditProfileBloc(
      this._employeeService, this._preference, this._userManager)
      : super(const EmployeeEditProfileState()) {
    on<EditProfileInitialLoadEvent>(_init);
    on<EditProfileDesignationChangedEvent>(_validDesignation);
    on<EditProfileNameChangedEvent>(_validName);
    on<EditProfileChangeDateOfBirthEvent>(_changeDateOfBirth);
    on<EditProfileChangeGenderEvent>(_changeGender);
    on<EditProfileUpdateProfileEvent>(_updateEmployeeDetails);
  }

  void _init(EditProfileInitialLoadEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    emit(state.copyWith(
        gender: event.gender, dateOfBirth: event.dateOfBirth?.toDate));
  }

  void _validDesignation(EditProfileDesignationChangedEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    if (event.designation.isEmpty) {
      emit(state.copyWith(designationError: true));
    } else {
      emit(state.copyWith(designationError: false));
    }
  }

  void _validName(EditProfileNameChangedEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    if (event.name.length < 4) {
      emit(state.copyWith(nameError: true));
    } else {
      emit(state.copyWith(nameError: false));
    }
  }

  void _changeDateOfBirth(EditProfileChangeDateOfBirthEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    emit(state.changeDateOfBirth(dateOfBirth: event.dateOfBirth));
  }

  void _changeGender(EditProfileChangeGenderEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    emit(state.changeGender(gender: event.gender));
  }

  void _updateEmployeeDetails(EditProfileUpdateProfileEvent event,
      Emitter<EmployeeEditProfileState> emit) async {
    emit(state.copyWith(status: EmployeeProfileState.loading));
    if (state.nameError || state.designationError) {
      emit(state.copyWith(
          status: EmployeeProfileState.failure, error: fillDetailsError));
    } else {
      try {
        Employee employee = Employee(
          id: _userManager.employeeId,
          roleType: _userManager.employee.roleType,
          name: event.name,
          employeeId: _userManager.employee.employeeId,
          email: _userManager.employee.email,
          designation: event.designation,
          level: event.level.isEmpty ? null : event.level,
          bloodGroup: event.bloodGroup.isEmpty ? null : event.bloodGroup,
          address: event.address.isEmpty ? null : event.address,
          imageUrl: _userManager.employee.imageUrl,
          gender: state.gender,
          dateOfBirth: state.dateOfBirth?.timeStampToInt,
          phone: event.phoneNumber.isEmpty ? null : event.phoneNumber,
          dateOfJoining: _userManager.employee.dateOfJoining,
        );
        await _employeeService.updateEmployeeDetails(employee: employee);
        _preference.setCurrentUser(employee);
        eventBus.fire(GetCurrentEmployeeUserSettingsEvent());
        emit(state.copyWith(status: EmployeeProfileState.success));
      } on Exception {
        emit(state.copyWith(
            status: EmployeeProfileState.failure,
            error: firestoreFetchDataError));
      }
    }
  }
}
