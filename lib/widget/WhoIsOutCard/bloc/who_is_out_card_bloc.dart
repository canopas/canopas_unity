import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/error_const.dart';
import '../../../../model/employee/employee.dart';
import '../../../../model/leave/leave.dart';
import '../../../../model/leave_application.dart';
import '../../../../services/admin/employee_service.dart';
import '../../../../services/admin/leave_service.dart';
import 'who_is_out_card_event.dart';
import 'who_is_out_card_state.dart';

@Injectable()
class WhoIsOutCardBloc extends Bloc<WhoIsOutEvent, WhoIsOutCardState> {
  final EmployeeService _employeeService;
  final AdminLeaveService _leaveService;

  WhoIsOutCardBloc(
      this._employeeService,
      this._leaveService,)
      : super(WhoIsOutCardState(dateOfAbsenceEmployee: DateTime.now())) {
    on<WhoIsOutInitialLoadEvent>(_load);
    on<ChangeToBeforeDateEvent>(_changeToBeforeDate);
    on<ChangeToAfterDateEvent>(_changeToAfterDate);
  }


  FutureOr<void> _load(WhoIsOutInitialLoadEvent event,Emitter<WhoIsOutCardState> emit) async {
    await _getAbsenceEmployees(emit);
  }

  Future<void> _changeToBeforeDate(ChangeToBeforeDateEvent event,Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(dateOfAbsenceEmployee: state.dateOfAbsenceEmployee.subtract(const Duration(days: 1))));
    await _getAbsenceEmployees(emit);
  }

  Future<void> _changeToAfterDate(ChangeToAfterDateEvent event,Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(dateOfAbsenceEmployee: state.dateOfAbsenceEmployee.add(const Duration(days: 1))));
   await  _getAbsenceEmployees(emit);
  }

 Future<void> _getAbsenceEmployees(Emitter<WhoIsOutCardState> emit) async {
   emit(state.copyWith(status: WhoOIsOutCardStatus.loading));
    try {
      List<Employee> employees = await _employeeService.getEmployees();
      List<Leave> absenceLeaves = await _leaveService.getAllAbsence(date: state.dateOfAbsenceEmployee);

      List<LeaveApplication> absenceEmployee = absenceLeaves
          .map((leave) {
            final employee =
                employees.firstWhereOrNull((emp) => emp.id == leave.uid);
            return (employee == null)
                ? null
                : LeaveApplication(employee: employee, leave: leave);
          })
          .whereNotNull()
          .toList();

      emit(state.copyWith(
          status: WhoOIsOutCardStatus.success, absence: absenceEmployee));
    } on Exception catch (_) {
      emit(state.failure(error: firestoreFetchDataError));
    }
  }


}
