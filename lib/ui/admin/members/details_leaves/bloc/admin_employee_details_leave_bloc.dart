import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/Repo/leave_repo.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/leave/leave.dart';
import 'admin_employee_details_leave_state.dart';
import 'admin_employee_details_leave_events.dart';

@Injectable()
class AdminEmployeeDetailsLeavesBLoc extends Bloc<
    AdminEmployeeDetailsLeavesEvents, AdminEmployeeDetailsLeavesState> {
  final LeaveRepo _leaveRepo;

  AdminEmployeeDetailsLeavesBLoc(this._leaveRepo)
      : super(const AdminEmployeeDetailsLeavesState()) {
    on<InitEvents>(_init);
  }

  Future<void> _init(
      InitEvents event, Emitter<AdminEmployeeDetailsLeavesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      return emit.forEach(
        _leaveRepo.userLeaves(event.employeeId),
        onData: (List<Leave> data) {
          final userLeaves = data.toList();
          userLeaves.sort((a, b) => b.startDate.compareTo(a.startDate));
          return state.copyWith(leaves: userLeaves, status: Status.success);
        },
        onError: (error, _) => state.copyWith(
            error: firestoreFetchDataError, status: Status.error),
      );
    } on Exception {
      emit(
          state.copyWith(error: firestoreFetchDataError, status: Status.error));
    }
  }
}
