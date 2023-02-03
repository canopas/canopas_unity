import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../exception/error_const.dart';
import '../../../../services/admin/employee_service.dart';
import 'admin_employee_state.dart';
import 'admin_employees_event.dart';

@Injectable()
class AdminEmployeesBloc extends Bloc<AdminEmployeesEvent, AdminEmployeesState> {
  final EmployeeService employeeService;

  AdminEmployeesBloc(this.employeeService) : super(AdminEmployeesInitialState()) {
    on<FetchEmployeesEventAdminEmployeesEvent>(_fetchEmployee);
  }

  _fetchEmployee(
      FetchEmployeesEventAdminEmployeesEvent event, Emitter<AdminEmployeesState> emit) async {
    emit(AdminEmployeesLoadingState());
    try {
      emit(AdminEmployeesSuccessState(
          employees: await employeeService.getEmployees()));
    } on Exception {
      emit(AdminEmployeesFailureState(error: firestoreFetchDataError));
    }
  }
}
