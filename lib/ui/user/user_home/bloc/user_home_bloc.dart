import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/provider/user_data.dart';
import '../../../../model/employee/employee.dart';
import '../../../../model/leave/leave.dart';
import '../../../../model/leave_application.dart';
import '../../../../services/admin/employee_service.dart';
import '../../../../services/admin/leave_service.dart';
import 'user_home_event.dart';
import 'user_home_state.dart';

@Injectable()
class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final UserManager _userManager;
  final EmployeeService _employeeService;
  final AdminLeaveService _leaveService;

  UserHomeBloc(this._userManager,
      this._employeeService,
      this._leaveService,)
      : super(UserHomeState(dateOfAbsenceEmployee: DateTime.now())) {
    on<UserHomeFetchEvent>(_load);
    on<ChangeToBeforeDateEvent>(_changeToBeforeDate);
    on<ChangeToAfterDateEvent>(_changeToAfterDate);
  }

  String get userID => _userManager.employeeId;

  FutureOr<void> _load(UserHomeFetchEvent event,Emitter<UserHomeState> emit) async {
    await _getAbsenceEmployees(emit);
  }

  Future<void> _changeToBeforeDate(ChangeToBeforeDateEvent event,Emitter<UserHomeState> emit) async {
    emit(state.copyWith(dateOfAbsenceEmployee: state.dateOfAbsenceEmployee.subtract(const Duration(days: 1))));
    await _getAbsenceEmployees(emit);
  }

  Future<void> _changeToAfterDate(ChangeToAfterDateEvent event,Emitter<UserHomeState> emit) async {
    emit(state.copyWith(dateOfAbsenceEmployee: state.dateOfAbsenceEmployee.add(const Duration(days: 1))));
   await  _getAbsenceEmployees(emit);
  }

 Future<void> _getAbsenceEmployees(Emitter<UserHomeState> emit) async {
   emit(state.copyWith(status: UserHomeStatus.loading));
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
          status: UserHomeStatus.success, absence: absenceEmployee));
    } on Exception catch (_) {
      emit(state.failure(error: firestoreFetchDataError));
    }
  }


}
