import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/services/leave_service.dart';
import 'admin_employee_details_leave_state.dart';
import 'admin_employee_details_leave_events.dart';

@Injectable()
class AdminEmployeeDetailsLeavesBLoc extends Bloc<
    AdminEmployeeDetailsLeavesEvents, AdminEmployeeDetailsLeavesState> {
  final LeaveService _leaveService;

  AdminEmployeeDetailsLeavesBLoc(this._leaveService)
      : super(const AdminEmployeeDetailsLeavesState()) {
    on<AdminEmployeeDetailsLeavesInitEvent>(_init);
  }

  _init(AdminEmployeeDetailsLeavesInitEvent event,
      Emitter<AdminEmployeeDetailsLeavesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<Leave> recentLeaves =
          await _leaveService.getRecentLeavesOfUser(event.employeeId);
      List<Leave> upcomingLeaves =
          await _leaveService.getUpcomingLeavesOfUser(event.employeeId);
      List<Leave> pastLeaves =
          await _leaveService.getPastLeavesOfUser(event.employeeId);
      emit(state.copyWith(
          recentLeaves: recentLeaves,
          pastLeaves: pastLeaves,
          upcomingLeaves: upcomingLeaves,
          status: Status.success,
          loading: false));
    } catch (e) {
      emit(
          state.copyWith(error: firestoreFetchDataError, status: Status.error));
    }
  }
}
