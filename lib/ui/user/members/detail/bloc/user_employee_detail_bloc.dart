import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_event.dart';
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/leave_service.dart';

@Injectable()
class UserEmployeeDetailBloc
    extends Bloc<UserEmployeeDetailEvent, UserEmployeeDetailState> {
  final EmployeeService _employeeService;
  final LeaveService _leaveService;

  UserEmployeeDetailBloc(this._employeeService, this._leaveService)
      : super(UserEmployeeDetailInitialState()) {
    on<UserEmployeeDetailFetchEvent>(_fetchInitialData);
  }

  Future<void> _fetchInitialData(UserEmployeeDetailFetchEvent event,
      Emitter<UserEmployeeDetailState> emit) async {
    emit(UserEmployeeDetailLoadingState());
    try {
      final employee = await _employeeService.getEmployee(event.employeeId);
      final leaves =
          await _leaveService.getUpcomingLeavesOfUser(event.employeeId);
      if (employee == null) {
        emit(UserEmployeeDetailErrorState(error: firestoreFetchDataError));
      } else {
        emit(UserEmployeeDetailSuccessState(
            employee: employee, upcomingLeaves: leaves));
      }
    } on Exception {
      emit(UserEmployeeDetailErrorState(error: firestoreFetchDataError));
    }
  }
}
