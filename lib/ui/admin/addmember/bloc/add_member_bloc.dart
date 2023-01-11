import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:uuid/uuid.dart';

import '../../../../services/admin/employee_service.dart';
import 'add_member_event.dart';
import 'add_member_state.dart';

@Injectable()
class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberFormState> {
  final EmployeeService _employeeService;


  AddMemberBloc(this._employeeService) : super(const AddMemberFormState()) {
    on<SelectRoleTypeEvent>(_selectRoleType);
    on<AddEmployeeNameEvent>(_validateName);
    on<AddEmployeeIdEvent>(_validateEmployeeId);
    on<AddEmployeeDesignationEvent>(_validateEmployeeDesignation);
    on<AddEmployeeEmailEvent>(_validateEmployeeEmail);
    on<AddDateOfJoiningDateEvent>(_validateDateOfJoining);
    on<SubmitEmployeeFormEvent>(_submitForm);
  }

  void _selectRoleType(
      SelectRoleTypeEvent event, Emitter<AddMemberFormState> emit) {
    emit(state.copyWith(role: event.roleType));
  }
  void _validateEmployeeId(
      AddEmployeeIdEvent event, Emitter<AddMemberFormState> emit) {
    if (validEmployeeId(event.employeeId)) {
      emit(state.copyWith(
          employeeId: event.employeeId,idError: false));
    } else {
      emit(state.copyWith(
          employeeId: event.employeeId,
          idError: true));
    }
  }

  void _validateName(
      AddEmployeeNameEvent event, Emitter<AddMemberFormState> emit) {
    if (validName(event.name)) {
      emit(state.copyWith(
          name: event.name,nameError: false));
    } else {
      emit(state.copyWith(
          nameError: true, name: event.name));
    }
  }



  void _validateEmployeeEmail(
      AddEmployeeEmailEvent event, Emitter<AddMemberFormState> emit) {
    if (validEmail(event.email) ) {
      emit(state.copyWith(
          email: event.email,emailError: false));
    } else {
      emit(state.copyWith(
          emailError: true,
          email: event.email));
    }
  }

  void _validateEmployeeDesignation(
      AddEmployeeDesignationEvent event, Emitter<AddMemberFormState> emit) {
    if (validDesignation(event.designation)) {
      emit(state.copyWith(
          designation: event.designation,
          designationError: false));
    } else {
      emit(state.copyWith(
          designationError: true,
          designation: event.designation));
    }
  }

  void _validateDateOfJoining(
      AddDateOfJoiningDateEvent event, Emitter<AddMemberFormState> emit) {
    if (event.dateOfJoining == null) {
      emit(state.copyWith(dateOfJoining: DateTime.now()));
    } else {
      emit(state.copyWith(dateOfJoining: event.dateOfJoining!));
    }
  }

  bool  validEmployeeId(String? employeeId)=>employeeId != null&&employeeId.length>=4;

  bool validName(String? name) =>name != null && name.length >= 4;

  bool validEmail(String? email) =>email != null && email.length >= 4 && email.contains('@');

  bool validDesignation(String? designation) =>designation != null && designation.length >= 4;

  bool get validForm=>
    validEmployeeId(state.employeeId)&& validName(state.name)&&validEmail(state.email)&& validDesignation(state.designation);

  Employee submitEmployee(){
    return Employee(
        id: const Uuid().v4(),
        roleType: state.role!,
        name: state.name!,
        employeeId: state.employeeId!,
        email: state.email!,
        designation: state.designation!,
        dateOfJoining: state.dateOfJoining==null?DateTime.now().timeStampToInt:state.dateOfJoining!.timeStampToInt);
  }


  void _submitForm(
      SubmitEmployeeFormEvent event, Emitter<AddMemberFormState> emit)async {
    emit(state.copyWith(status: SubmitFormStatus.loading));
    if (validForm) {
      try {
        Employee employee= submitEmployee();
        bool employeeExists=await _employeeService.hasUser(employee.email);
        if(employeeExists){
          emit(state.copyWith(status:  SubmitFormStatus.error,msg: userAlreadyExists));
        }else{
          await _employeeService.addEmployee(employee);
          emit(state.copyWith(status: SubmitFormStatus.done));
        }

      } on Exception {
        emit(state.copyWith(
            status: SubmitFormStatus.error, msg: firestoreFetchDataError));
      }
    } else {
      emit(state.copyWith(
          status: SubmitFormStatus.error, msg: fillDetailsError));
    }
  }
}
