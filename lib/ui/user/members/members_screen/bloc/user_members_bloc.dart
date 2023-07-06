import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_event.dart';
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_state.dart';
import '../../../../../data/Repo/employee_repo.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/employee/employee.dart';

@Injectable()
class UserEmployeesBloc extends Bloc<UserEmployeesEvent, UserEmployeesState> {
  final EmployeeRepo _employeeRepo;

  UserEmployeesBloc(this._employeeRepo) : super(UserEmployeesInitialState()) {
    on<FetchEmployeesEvent>(_fetchEmployee);
  }

  Future<void> _fetchEmployee(
      FetchEmployeesEvent event, Emitter<UserEmployeesState> emit) async {
    emit(UserEmployeesLoadingState());
    try {
      return emit.forEach(_employeeRepo.activeEmployees,
          onData: (List<Employee> employees) =>
              UserEmployeesSuccessState(employees: employees),
          onError: (error, stackTrace) =>
              UserEmployeesFailureState(error: firestoreFetchDataError));
    } on Exception {
      emit(UserEmployeesFailureState(error: firestoreFetchDataError));
    }
  }
}
