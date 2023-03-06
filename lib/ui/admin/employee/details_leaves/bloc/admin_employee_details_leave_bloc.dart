import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import '../../../../../model/leave/leave.dart';
import 'admin_employee_details_leave_state.dart';
import 'admin_employee_details_leave_events.dart';

@Injectable()
class AdminEmployeeDetailsLeavesBLoc extends Bloc<
    AdminEmployeeDetailsLeavesEvents, AdminEmployeeDetailsLeavesState> {
  final UserLeaveService _userLeaveService;

  AdminEmployeeDetailsLeavesBLoc(this._userLeaveService)
      : super(const AdminEmployeeDetailsLeavesState()) {
    on<AdminEmployeeDetailsLeavesInitEvent>(_init);
  }

  _init(AdminEmployeeDetailsLeavesInitEvent event,
      Emitter<AdminEmployeeDetailsLeavesState> emit) async {
    try {
      emit(state.copyWith(loading: true));
      List<Leave> recentLeaves = await _userLeaveService.getRecentLeavesOfUser(event.employeeId);
      List<Leave> upcomingLeaves = await _userLeaveService.getUpcomingLeaves(event.employeeId);
      List<Leave> pastLeaves = await _userLeaveService.getPastLeavesOfUser(event.employeeId);
      emit(state.copyWith(
          recentLeaves: recentLeaves,
          pastLeaves: pastLeaves,
          upcomingLeaves: upcomingLeaves,
          loading: false));
    } catch (e) {
      emit(state.copyWith(error: firestoreFetchDataError, loading: false));
    }
  }
}
