import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_events.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_state.dart';

import '../../../../services/admin/employee_service.dart';

@Injectable()
class AdminEditEmployeeDetailsBloc extends Bloc<AdminEditEmployeeDetailsEvents,
    AdminEditEmployeeDetailsState> {
  final EmployeeService _employeeService;

  AdminEditEmployeeDetailsBloc(this._employeeService)
      : super(const AdminEditEmployeeDetailsState()) {
    on<AdminEditEmployeeDetailsInitialEvent>(_initRoleTypeAndDate);
    on<ChangeRoleTypeAdminEditEmployeeDetailsEvent>(_changeRoleType);
    on<UpdateEmployeeDetailsAdminEditEmployeeDetailsEvent>(_updateEmployee);
    on<ChangeDateOfJoiningAdminEditEmployeeDetailsEvent>(_changeDateOfJoining);
    on<ValidDesignationAdminEditEmployeeDetailsEvent>(_validDesignation);
    on<ValidEmailAdminEditEmployeeDetailsEvent>(_validEmail);
    on<ValidEmployeeIdAdminEditEmployeeDetailsEvent>(_validEmployeeId);
    on<ValidNameAdminEditEmployeeDetailsEvent>(_validName);
  }

  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController designationFieldController =
      TextEditingController();
  final TextEditingController levelFieldController = TextEditingController();
  final TextEditingController employeeIDFieldController =
      TextEditingController();
  final TextEditingController dateOfJoiningFieldController =
      TextEditingController();

  void _initRoleTypeAndDate(AdminEditEmployeeDetailsInitialEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    nameFieldController.text = event.employee.name;
    emailFieldController.text = event.employee.email;
    designationFieldController.text = event.employee.designation;
    levelFieldController.text = event.employee.level ?? "";
    employeeIDFieldController.text = event.employee.employeeId;
    emit(state.copyWith(
        roleType: event.employee.roleType,
        dateOfJoining:
            event.employee.dateOfJoining?.toDate ?? DateTime.now().dateOnly));
  }

  void _changeRoleType(ChangeRoleTypeAdminEditEmployeeDetailsEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(roleType: event.roleType));
  }

  void _changeDateOfJoining(
      ChangeDateOfJoiningAdminEditEmployeeDetailsEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(dateOfJoining: event.dateOfJoining));
  }

  void _validName(ValidNameAdminEditEmployeeDetailsEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    if (event.name.length < 4) {
      emit(state.copyWith(nameError: true));
    } else {
      emit(state.copyWith(nameError: false));
    }
  }

  void _validEmail(ValidEmailAdminEditEmployeeDetailsEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    if (event.email.isEmpty || !event.email.contains('@')) {
      emit(state.copyWith(emailError: true));
    } else {
      emit(state.copyWith(emailError: false));
    }
  }

  void _validDesignation(ValidDesignationAdminEditEmployeeDetailsEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    if (event.designation.isEmpty) {
      emit(state.copyWith(designationError: true));
    } else {
      emit(state.copyWith(designationError: false));
    }
  }

  void _validEmployeeId(ValidEmployeeIdAdminEditEmployeeDetailsEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    if (event.employeeId.isEmpty) {
      emit(state.copyWith(employeeIdError: true));
    } else {
      emit(state.copyWith(employeeIdError: false));
    }
  }

  void _updateEmployee(UpdateEmployeeDetailsAdminEditEmployeeDetailsEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) async {
    emit(state.copyWith(
        adminEditEmployeeDetailsStatus:
            AdminEditEmployeeDetailsStatus.loading));
    if (state.nameError ||
        state.designationError ||
        state.employeeIdError ||
        state.emailError) {
      emit(state.copyWith(
          adminEditEmployeeDetailsStatus:
              AdminEditEmployeeDetailsStatus.failure,
          error: fillDetailsError));
    } else {
      try {
        await _employeeService.adminUpdateEmployeeDetails(
          id: event.id,
          name: nameFieldController.text,
          employeeId: employeeIDFieldController.text,
          email: emailFieldController.text,
          level: levelFieldController.text.isEmpty
              ? null
              : levelFieldController.text,
          designation: designationFieldController.text,
          roleType: state.roleType,
          dateOfJoining: state.dateOfJoining!.timeStampToInt,
        );
        emit(state.copyWith(
            adminEditEmployeeDetailsStatus:
                AdminEditEmployeeDetailsStatus.success));
      } on Exception {
        emit(state.copyWith(
            adminEditEmployeeDetailsStatus:
                AdminEditEmployeeDetailsStatus.failure,
            error: firestoreFetchDataError));
      }
    }
  }

  @override
  Future<void> close() {
    nameFieldController.dispose();
    emailFieldController.dispose();
    designationFieldController.dispose();
    levelFieldController.dispose();
    employeeIDFieldController.dispose();
    dateOfJoiningFieldController.dispose();
    return super.close();
  }
}
