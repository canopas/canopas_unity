import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../exception/error_const.dart';
import '../../../../../services/admin/paid_leave_service.dart';
import '../../../../../services/user/user_leave_service.dart';
import 'admin_leave_detail_event.dart';
import 'admin_leave_detail_state.dart';

@Injectable()
class AdminLeaveDetailBloc
    extends Bloc<LeaveApplicationDetailEvent, AdminLeaveDetailState> {
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;

  AdminLeaveDetailBloc(this._userLeaveService, this._paidLeaveService)
      : super(AdminLeaveDetailInitialState()) {
    on<FetchLeaveApplicationDetailEvent>(_fetchLeaveApplicationDetail);
    on<DeleteLeaveApplicationEvent>(_deleteLeaveApplication);
  }

  Future<void> _fetchLeaveApplicationDetail(
      FetchLeaveApplicationDetailEvent event,
      Emitter<AdminLeaveDetailState> emit) async {
    emit(AdminLeaveDetailLoadingState());
    try {
      int paidLeaves = await _paidLeaveService.getPaidLeaves();
      double usedLeave = await _userLeaveService
          .getUserUsedLeaveCount(event.leaveApplication.employee.id);
      emit(AdminLeaveDetailSuccessState(
          usedLeaves: usedLeave, paidLeaves: paidLeaves));
    } on Exception {
      emit(AdminLeaveDetailFailureState(error: firestoreFetchDataError));
    }
  }

  Future<void> _deleteLeaveApplication(DeleteLeaveApplicationEvent event,
      Emitter<AdminLeaveDetailState> emit) async {
    emit(DeleteLeaveApplicationLoadingState());
    try {
      _userLeaveService.deleteLeaveRequest(event.leaveId);
      emit(DeleteLeaveApplicationSuccessState());
    } on Exception {
      emit(AdminLeaveDetailFailureState(error: firestoreFetchDataError));
    }
  }
}
