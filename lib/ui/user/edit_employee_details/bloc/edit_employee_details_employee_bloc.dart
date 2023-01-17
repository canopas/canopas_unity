import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/event_bus/events.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/ui/user/edit_employee_details/bloc/edit_employee_details_employee_state.dart';
import '../../../../exception/error_const.dart';
import '../../../../pref/user_preference.dart';
import '../../../../services/admin/employee_service.dart';
import '../../setting/bloc/employee_setting_event.dart';
import 'edit_employee_details_employee_event.dart';

@Injectable()
class EmployeeEditEmployeeDetailsBloc extends Bloc<
    EmployeeEditEmployeeDetailsEvents, EmployeeEditEmployeeDetailsState> {
  final EmployeeService _employeeService;
  final UserManager _userManager;
  final UserPreference _preference;

  EmployeeEditEmployeeDetailsBloc(
      this._employeeService, this._preference, this._userManager)
      : super(const EmployeeEditEmployeeDetailsState()) {
    on<EmployeeEditEmployeeDetailsInitialLoadEvent>(_init);
    on<ValidDesignationEmployeeEditEmployeeDetailsEvent>(_validDesignation);
    on<ValidNameEmployeeEditEmployeeDetailsEvent>(_validName);
    on<ChangeDateOfBirthEvent>(_changeDateOfBirth);
    on<ChangeGenderEvent>(_changeGender);
    on<UpdateEmployeeDetailsEvent>(_updateEmployeeDetails);
  }

  void _init(EmployeeEditEmployeeDetailsInitialLoadEvent event,
      Emitter<EmployeeEditEmployeeDetailsState> emit) {
    emit(state.copyWith(
        gender: event.gender, dateOfBirth: event.dateOfBirth?.toDate));
  }

  void _validDesignation(ValidDesignationEmployeeEditEmployeeDetailsEvent event,
      Emitter<EmployeeEditEmployeeDetailsState> emit) {
    if (event.designation.isEmpty) {
      emit(state.copyWith(designationError: true));
    } else {
      emit(state.copyWith(designationError: false));
    }
  }

  void _validName(ValidNameEmployeeEditEmployeeDetailsEvent event,
      Emitter<EmployeeEditEmployeeDetailsState> emit) {
    if (event.name.length < 4) {
      emit(state.copyWith(nameError: true));
    } else {
      emit(state.copyWith(nameError: false));
    }
  }

  void _changeDateOfBirth(ChangeDateOfBirthEvent event,
      Emitter<EmployeeEditEmployeeDetailsState> emit) {
    emit(state.changeDateOfBirth(dateOfBirth: event.dateOfBirth));
  }

  void _changeGender(
      ChangeGenderEvent event, Emitter<EmployeeEditEmployeeDetailsState> emit) {
    emit(state.changeGender(gender: event.gender));
  }

  void _updateEmployeeDetails(UpdateEmployeeDetailsEvent event,
      Emitter<EmployeeEditEmployeeDetailsState> emit) async {
    emit(state.copyWith(status: EmployeeEditEmployeeDetailsStatus.loading));
    if (state.nameError || state.designationError) {
      emit(state.copyWith(
          status: EmployeeEditEmployeeDetailsStatus.failure,
          error: fillDetailsError));
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
        eventBus.fire(UpdateUserDetailsOnEmployeeSettingEvent());
        emit(state.copyWith(status: EmployeeEditEmployeeDetailsStatus.success));
      } on Exception {
        emit(state.copyWith(
            status: EmployeeEditEmployeeDetailsStatus.failure,
            error: firestoreFetchDataError));
      }
    }
  }
}
