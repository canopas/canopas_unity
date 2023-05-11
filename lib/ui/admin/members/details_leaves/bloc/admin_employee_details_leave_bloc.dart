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
    on<InitEvents>(_init);
  }

  _init(InitEvents event, Emitter<AdminEmployeeDetailsLeavesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<Leave> leaves = await _leaveService.getAllLeavesOfUser(event.employeeId);
      leaves.sort((a, b) => b.startDate.compareTo(a.startDate));
      emit(state.copyWith(leaves: leaves, status: Status.success));
    } catch (_) {
      emit(
          state.copyWith(error: firestoreFetchDataError, status: Status.error));
    }
  }
}
