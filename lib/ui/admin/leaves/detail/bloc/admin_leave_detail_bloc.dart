import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/services/space_service.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/provider/user_data.dart';
import '../../../../../data/services/leave_service.dart';
import 'admin_leave_detail_event.dart';
import 'admin_leave_detail_state.dart';

@Injectable()
class AdminLeaveDetailBloc
    extends Bloc<LeaveApplicationDetailEvent, AdminLeaveDetailState> {
  final UserManager _userManager;
  final SpaceService _spaceService;
  final LeaveService _leaveService;

  AdminLeaveDetailBloc(this._leaveService,this._userManager, this._spaceService)
      : super(AdminLeaveDetailInitialState()) {
    on<FetchLeaveApplicationDetailEvent>(_fetchLeaveApplicationDetail);
    on<DeleteLeaveApplicationEvent>(_deleteLeaveApplication);
  }

  Future<void> _fetchLeaveApplicationDetail(
      FetchLeaveApplicationDetailEvent event,
      Emitter<AdminLeaveDetailState> emit) async {
    emit(AdminLeaveDetailLoadingState());
    try {
      int paidLeaves = await _spaceService.getPaidLeaves(spaceId: _userManager.currentSpaceId!);
      double usedLeave =
          await _leaveService.getUserUsedLeaves(event.employeeId);
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
      _leaveService.deleteLeaveRequest(event.leaveId);
      emit(DeleteLeaveApplicationSuccessState());
    } on Exception {
      emit(AdminLeaveDetailFailureState(error: firestoreFetchDataError));
    }
  }
}
