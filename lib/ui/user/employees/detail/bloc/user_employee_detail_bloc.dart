import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_event.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_state.dart';

import '../../../../../services/admin/employee_service.dart';
import '../../../../../services/user/user_leave_service.dart';

class UserEmployeeDetailBloc
    extends Bloc<UserEmployeeDetailEvent, UserEmployeeDetailState> {
  final EmployeeService _employeeService;
  final UserLeaveService _userLeaveService;
  UserEmployeeDetailBloc(this._employeeService, this._userLeaveService)
      : super(UserEmployeeDetailInitialState()) {
    on<UserEmployeeDetailFetchEvent>(_fetchInitialData);
  }

  Future<void> _fetchInitialData(UserEmployeeDetailFetchEvent event,
      Emitter<UserEmployeeDetailState> emit) async {
    emit(UserEmployeeDetailLoadingState());
    try {
      final employee = await _employeeService.getEmployee(event.employeeId);
      final leaves =
          await _userLeaveService.getUpcomingLeaves(event.employeeId);
      if (employee == null) {
        emit(UserEmployeeDetailErrorState(error: firestoreFetchDataError));
      }
      emit(UserEmployeeDetailSuccessState(
          employee: employee!, upcomingLeaves: leaves));
    } on Exception {
      emit(UserEmployeeDetailErrorState(error: firestoreFetchDataError));
    }
  }
}
