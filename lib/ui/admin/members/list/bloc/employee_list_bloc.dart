import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/services/employee_service.dart';
import 'employee_list_event.dart';
import 'employee_list_state.dart';

@Injectable()
class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final EmployeeService _employeeService;
  StreamSubscription? _subscription;

  EmployeeListBloc(this._employeeService) : super(EmployeeListInitialState()) {
    on<EmployeeListInitialLoadEvent>(_onPageLoad);
    _subscription =
        eventBus.on<EmployeeListUpdateEvent>().listen((event) async {
      add(EmployeeListInitialLoadEvent());
    });
  }

  Future<void> _onPageLoad(EmployeeListInitialLoadEvent event,
      Emitter<EmployeeListState> emit) async {
    emit(EmployeeListLoadingState());
    try {
      List<Employee> employees = await _employeeService.getEmployees();
      emit(EmployeeListLoadedState(employees: List.from(employees)));
    } on Exception {
      emit(const EmployeeListFailureState(error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
