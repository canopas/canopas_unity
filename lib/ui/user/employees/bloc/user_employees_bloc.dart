import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/ui/user/employees/bloc/user_employee_state.dart';
import 'package:projectunity/ui/user/employees/bloc/user_employees_event.dart';

@Injectable()
class UserEmployeesBloc extends Bloc<UserEmployeesEvent, UserEmployeesState> {
  final EmployeeService employeeService;

  UserEmployeesBloc(this.employeeService) : super(UserEmployeesInitialState()) {
    on<FetchEmployeesEvent>(_fetchEmployee);
  }

  _fetchEmployee(
      FetchEmployeesEvent event, Emitter<UserEmployeesState> emit) async {
    emit(UserEmployeesLoadingState());
    try {
      emit(UserEmployeesSuccessState(
          employees: await employeeService.getEmployees()));
    } on Exception {
      emit(UserEmployeesFailureState(error: firestoreFetchDataError));
    }
  }
}
