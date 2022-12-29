import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/role.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/services/admin/employee/employee_service.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_event.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_state.dart';
import '../../../../../model/employee/employee.dart';


@Injectable()
class EmployeeDetailBloc
    extends Bloc<EmployeeDetailEvent, AdminEmployeeDetailState> {
  final EmployeeService _employeeService;

  EmployeeDetailBloc( this._employeeService)
      : super(EmployeeDetailInitialState()) {
    on<EmployeeDetailInitialLoadEvent>(_onInitialLoad);
    on<DeleteEmployeeEvent>(_onDeleteEmployeeEvent);
    on<EmployeeDetailsChangeRoleTypeEvent>(_makeAndRemoveAsAdmin);
  }

  Future<void> _onInitialLoad(EmployeeDetailInitialLoadEvent event,
      Emitter<AdminEmployeeDetailState> emit) async {

        emit(EmployeeDetailLoadingState());

    try {
      Employee? employee =
          await _employeeService.getEmployee(event.employeeId);
      if (employee != null) {
        emit(EmployeeDetailLoadedState(employee: employee));
      } else {
        emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
      }
    } on Exception{
      emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
    }
  }

  Future<void> _makeAndRemoveAsAdmin(EmployeeDetailsChangeRoleTypeEvent event,
      Emitter<AdminEmployeeDetailState> emit) async {
    if(state is EmployeeDetailLoadedState){
      final loadedState = state as EmployeeDetailLoadedState;
      try {
        if (loadedState.employee.roleType == kRoleTypeAdmin) {
          _employeeService.changeEmployeeRoleType(
              loadedState.employee.id, kRoleTypeEmployee);
        } else {
          _employeeService.changeEmployeeRoleType(
              loadedState.employee.id, kRoleTypeAdmin);
        }
      }on Exception {
        emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
      }
    }
  }

  Future<bool> _onDeleteEmployeeEvent(DeleteEmployeeEvent event,
      Emitter<AdminEmployeeDetailState> emit) async {
    try {
        await _employeeService.deleteEmployee(event.employeeId);
        return true;
    } on Exception {
      emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
      return false;
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}