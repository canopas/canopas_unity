import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/services/admin/employee/employee_service.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_event.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_state.dart';

import '../../../../../model/employee/employee.dart';
import '../../../../../navigation/navigation_stack_manager.dart';


@Injectable()
class EmployeeDetailBloc
    extends Bloc<EmployeeDetailEvent, AdminEmployeeDetailState> {
  final NavigationStackManager _navigationStackManager;
  final EmployeeService _employeeService;

  EmployeeDetailBloc(this._navigationStackManager, this._employeeService)
      : super(EmployeeDetailInitialState()) {
    on<EmployeeDetailInitialLoadEvent>(_onInitialLoad);
    on<DeleteEmployeeEvent>(_onDeleteEmployeeEvent);
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

  Future<void> _onDeleteEmployeeEvent(DeleteEmployeeEvent event,
      Emitter<AdminEmployeeDetailState> emit) async {
    try {
        await _employeeService.deleteEmployee(event.employeeId);
        _navigationStackManager.pop();
    } on Exception {
      emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}