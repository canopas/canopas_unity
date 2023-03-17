import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_event.dart';
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/provider/user_data.dart';
import '../../../../../data/services/employee_service.dart';

@Injectable()
class UserEmployeesBloc extends Bloc<UserEmployeesEvent, UserEmployeesState> {
  final EmployeeService employeeService;
  final UserManager _userManager;

  UserEmployeesBloc(this.employeeService, this._userManager)
      : super(UserEmployeesInitialState()) {
    on<FetchEmployeesEvent>(_fetchEmployee);
  }

  Future<void> _fetchEmployee(
      FetchEmployeesEvent event, Emitter<UserEmployeesState> emit) async {
    emit(UserEmployeesLoadingState());
    try {
      final allEmployees = await employeeService.getEmployees();
      final employees = allEmployees
          .where((employee) => employee.id != _userManager.employeeId)
          .toList(growable: true);
      emit(UserEmployeesSuccessState(employees: employees));
    } on Exception {
      emit(UserEmployeesFailureState(error: firestoreFetchDataError));
    }
  }
}
