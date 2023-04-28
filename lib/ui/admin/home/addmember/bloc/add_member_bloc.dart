import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/mixin/input_validation.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:uuid/uuid.dart';

import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/services/employee_service.dart';
import 'add_member_event.dart';
import 'add_member_state.dart';

@Injectable()
class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberFormState> with InputValidationMixin{
  final EmployeeService _employeeService;

  AddMemberBloc(this._employeeService) : super(const AddMemberFormState()) {
    on<SelectRoleEvent>(_selectRole);
    on<AddEmployeeNameEvent>(_validateName);
    on<AddEmployeeIdEvent>(_validateEmployeeId);
    on<AddEmployeeDesignationEvent>(_validateEmployeeDesignation);
    on<AddEmployeeEmailEvent>(_validateEmployeeEmail);
    on<AddDateOfJoiningDateEvent>(_validateDateOfJoining);
    on<SubmitEmployeeFormEvent>(_submitForm);
  }

  void _selectRole(SelectRoleEvent event, Emitter<AddMemberFormState> emit) {
    emit(state.copyWith(role: event.role));
  }

  void _validateEmployeeId(
      AddEmployeeIdEvent event, Emitter<AddMemberFormState> emit) {
    if (validInputLength(event.employeeId)) {
      emit(state.copyWith(employeeId: event.employeeId, idError: false));
    } else {
      emit(state.copyWith(employeeId: event.employeeId, idError: true));
    }
  }

  void _validateName(
      AddEmployeeNameEvent event, Emitter<AddMemberFormState> emit) {
    if (validInputLength(event.name)) {
      emit(state.copyWith(name: event.name, nameError: false));
    } else {
      emit(state.copyWith(nameError: true, name: event.name));
    }
  }

  void _validateEmployeeEmail(
      AddEmployeeEmailEvent event, Emitter<AddMemberFormState> emit) {
    if (validEmail(event.email)) {
      emit(state.copyWith(email: event.email, emailError: false));
    } else {
      emit(state.copyWith(emailError: true, email: event.email));
    }
  }

  void _validateEmployeeDesignation(
      AddEmployeeDesignationEvent event, Emitter<AddMemberFormState> emit) {
      emit(state.copyWith(
          designation: event.designation, designationError: false));
  }

  void _validateDateOfJoining(
      AddDateOfJoiningDateEvent event, Emitter<AddMemberFormState> emit) {
    if (event.dateOfJoining == null) {
      emit(state.copyWith(dateOfJoining: DateTime.now()));
    } else {
      emit(state.copyWith(dateOfJoining: event.dateOfJoining!));
    }
  }


  bool get validForm =>
      validInputLength(state.employeeId) &&
      validInputLength(state.name) &&
      validEmail(state.email);

  Employee submitEmployee() {
    return Employee(
        uid: const Uuid().v4(),
        role: state.role!,
        name: state.name!,
        employeeId: state.employeeId!,
        email: state.email!,
        designation: state.designation!,
        dateOfJoining: state.dateOfJoining == null
            ? DateTime.now().timeStampToInt
            : state.dateOfJoining!.timeStampToInt);
  }

  void _submitForm(
      SubmitEmployeeFormEvent event, Emitter<AddMemberFormState> emit) async {
    emit(state.copyWith(status: Status.loading));
    if (validForm) {
      try {
        Employee employee = submitEmployee();
        bool employeeExists = await _employeeService.hasUser(employee.email);
        if (employeeExists) {
          emit(state.copyWith(status: Status.error, msg: userAlreadyExists));
        } else {
          await _employeeService.addEmployee(employee);
          emit(state.copyWith(status: Status.success));
        }
      } on Exception {
        emit(
            state.copyWith(status: Status.error, msg: firestoreFetchDataError));
      }
    } else {
      emit(state.copyWith(status: Status.error, msg: fillDetailsError));
    }
  }
}
