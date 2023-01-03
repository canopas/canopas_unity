import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/edit_employee_details_events.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/edit_employee_details_state.dart';
import '../../../../services/admin/employee/employee_service.dart';

class AdminEditEmployeeDetailsBloc extends Bloc<AdminEditEmployeeDetailsEvents,
    AdminEditEmployeeDetailsState> {
  final EmployeeService _employeeService;

  AdminEditEmployeeDetailsBloc(this._employeeService)
      : super(const AdminEditEmployeeDetailsState()) {
    on<GetEmployeeDetailsAdminEditEmployeeDetailsEvents>(_initFetchEmployee);
    on<ChangeNameAdminEditEmployeeDetailsEvents>(_changeName);
    on<ChangeEmailAdminEditEmployeeDetailsEvents>(_changeEmail);
    on<ChangePhoneNumberAdminEditEmployeeDetailsEvents>(_changePhoneNumber);
    on<ChangeEmployeeIdAdminEditEmployeeDetailsEvents>(_changeEmployeeId);
    on<ChangeDesignationAdminEditEmployeeDetailsEvents>(_changeDesignation);
    on<ChangeRoleTypeAdminEditEmployeeDetailsEvents>(_changeRoleType);
    on<ChangeDateOfJoiningAdminEditEmployeeDetailsEvents>(_changeDateOfJoining);
    on<ChangeLevelAdminEditEmployeeDetailsEvents>(_changeLevel);
    on<UpdateEmployeeDetailsAdminEditEmployeeDetailsEvents>(_updateEmployee);
  }

  _initFetchEmployee(GetEmployeeDetailsAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(
      id: event.employee.id,
      dateOfJoining:
          event.employee.dateOfJoining?.toDate ?? DateTime.now().dateOnly,
      phoneNumber: event.employee.phone,
      employeeId: event.employee.employeeId,
      designation: event.employee.designation,
      email: event.employee.email,
      roleType: event.employee.roleType,
      level: event.employee.level,
      name: event.employee.name,
    ));
  }

  _changeName(ChangeNameAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(name: event.name));
  }

  _changeEmail(ChangeEmailAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(email: event.email));
  }

  _changePhoneNumber(ChangePhoneNumberAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  _changeEmployeeId(ChangeEmployeeIdAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(employeeId: event.employeeId));
  }

  _changeDesignation(ChangeDesignationAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(designation: event.designation));
  }

  _changeRoleType(ChangeRoleTypeAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(roleType: event.roleType));
  }

  _changeDateOfJoining(ChangeDateOfJoiningAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(dateOfJoining: event.dateOfJoining));
  }

  _changeLevel(ChangeLevelAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(level: event.level));
  }

  _updateEmployee(UpdateEmployeeDetailsAdminEditEmployeeDetailsEvents event,
      Emitter<AdminEditEmployeeDetailsState> emit) async {
    emit(state.copyWith(
        adminEditEmployeeDetailsStatus:
            AdminEditEmployeeDetailsStatus.loading));

    if (state.id != null) {
      try {
        await _employeeService.adminUpdateEmployeeDetails(
          id: state.id!,
          name: state.name,
          employeeId: state.employeeId,
          email: state.email,
          phone: state.phoneNumber,
          level: state.level,
          designation: state.designation,
          roleType: state.roleType,
          dateOfJoining: state.dateOfJoining!.timeStampToInt,
        );
        emit(state.copyWith(adminEditEmployeeDetailsStatus: AdminEditEmployeeDetailsStatus.success));
      } on Exception {
        emit(state.copyWith(adminEditEmployeeDetailsStatus: AdminEditEmployeeDetailsStatus.failure, error: firestoreFetchDataError));
      }
    } else {
      emit(state.copyWith(adminEditEmployeeDetailsStatus: AdminEditEmployeeDetailsStatus.failure, error: firestoreFetchDataError));
    }
  }
}
