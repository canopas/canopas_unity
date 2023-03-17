import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/services/paid_leave_service.dart';
import 'admin_setting_update_leave_count_screen_event.dart';
import 'admin_setting_update_leave_count_screen_state.dart';

@Injectable()
class AdminSettingUpdatePaidLeaveCountBloc extends Bloc<
    AdminSettingUpdatePaidLeaveCountEvent, AdminSettingUpdateLeaveCountState> {
  final PaidLeaveService _paidLeaveService;

  AdminSettingUpdatePaidLeaveCountBloc(this._paidLeaveService)
      : super(AdminSettingUpdateLeaveCountInitialState()) {
    on<AdminSettingPaidLeaveCountInitialLoadEvent>(_initialLoad);
    on<UpdatePaidLeaveCountEvent>(_updatePaidLeaveCount);
  }

  Future<void> _initialLoad(AdminSettingPaidLeaveCountInitialLoadEvent event,
      Emitter<AdminSettingUpdateLeaveCountState> emit) async {
    emit(AdminSettingUpdateLeaveCountLoadingState());
    try {
      emit(AdminSettingUpdateLeaveCountSuccessState(
          paidLeaveCount: await _paidLeaveService.getPaidLeaves()));
    } on Exception {
      emit(AdminSettingUpdateLeaveCountFailureState(
          error: firestoreFetchDataError));
    }
  }

  Future<void> _updatePaidLeaveCount(UpdatePaidLeaveCountEvent event,
      Emitter<AdminSettingUpdateLeaveCountState> emit) async {
    emit(AdminSettingUpdateLeaveCountLoadingState());
    try {
      int leaveCount = int.parse(event.leaveCount);
      await _paidLeaveService.updateLeaveCount(leaveCount);
      emit(AdminSettingLeavesUpdatedState());
    } on Exception {
      emit(AdminSettingUpdateLeaveCountFailureState(
          error: firestoreFetchDataError));
    }
  }
}
