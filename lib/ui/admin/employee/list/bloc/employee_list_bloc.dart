import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_event.dart';
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_state.dart';

import '../../../../../exception/error_const.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../navigation/navigation_stack_manager.dart';
import '../../../../../services/admin/employee/employee_service.dart';


@Injectable()
class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final EmployeeService _employeeService;
  final NavigationStackManager _navigationStackManager;

  EmployeeListBloc(this._employeeService, this._navigationStackManager)
      : super( EmployeeListInitialState()) {
    on<EmployeeListInitialLoadEvent>(_onPageLoad);
    on<EmployeeListNavigationToEmployeeDetailEvent>(_navigateToEmployeeDetail);
  }

  Future<void> _onPageLoad(EmployeeListInitialLoadEvent event,
      Emitter<EmployeeListState> emit) async {
    emit(EmployeeListLoadingState());
    try {
      List<Employee> employees = await _employeeService.getEmployees();
      emit(EmployeeListLoadedState(employees: employees));
    } on Exception {
      emit( EmployeeListFailureState(error: firestoreFetchDataError));
    }
  }

  Future<void> _navigateToEmployeeDetail(
      EmployeeListNavigationToEmployeeDetailEvent event,
      Emitter<EmployeeListState> emit) async {
    _navigationStackManager
        .push(NavStackItem.employeeDetailState(id: event.id));
  }
}
