import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../exception/error_const.dart';
import '../../../../../navigation/navigation_stack_manager.dart';
import '../../../../../services/admin/paid_leave/paid_leave_service.dart';
import 'admin_setting_update_leave_count_screen_event.dart';
import 'admin_setting_update_leave_count_screen_state.dart';

@Injectable()
class AdminSettingUpdatePaidLeaveCountBloc extends Bloc<AdminSettingUpdatePaidLeaveCountEvent,AdminSettingUpdateLeaveCountState>{
  final PaidLeaveService _paidLeaveService;
  final NavigationStackManager _stateManager;
  AdminSettingUpdatePaidLeaveCountBloc(this._paidLeaveService, this._stateManager) : super(AdminSettingUpdateLeaveCountInitialState()){

    on<AdminSettingPaidLeaveCountInitialLoadEvent>(_initialLoad);
    on<UpdatePaidLeaveCountEvent>(_updatePaidLeaveCount);

  }

  _initialLoad(AdminSettingPaidLeaveCountInitialLoadEvent event, Emitter<AdminSettingUpdateLeaveCountState> emit) async {
    emit(AdminSettingUpdateLeaveCountLoadingState());
    try {
      emit(AdminSettingUpdateLeaveCountSuccessState(
          paidLeaveCount: await _paidLeaveService.getPaidLeaves()));
    }on Exception {
      emit(AdminSettingUpdateLeaveCountFailureState(error: firestoreFetchDataError));
    }
  }

  _updatePaidLeaveCount(UpdatePaidLeaveCountEvent event, Emitter<AdminSettingUpdateLeaveCountState> emit) async {
    try{
     emit(AdminSettingUpdateLeaveCountLoadingState());
     int leaveCount  = int.parse(event.leaveCount);
       await _paidLeaveService.updateLeaveCount(leaveCount);
       _stateManager.pop();
    } on Exception{
      emit(AdminSettingUpdateLeaveCountFailureState(error: firestoreFetchDataError));
    }
  }

}

