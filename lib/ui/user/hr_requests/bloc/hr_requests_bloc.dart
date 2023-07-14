import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/provider/user_state.dart';
import '../../../../data/services/hr_request_service.dart';
import 'hr_requests_events.dart';
import 'hr_requests_states.dart';

@Injectable()
class HrRequestsBloc
    extends Bloc<HrRequestsEvents, HrRequestsState> {
  final HrRequestService _hrRequestService;
  final UserStateNotifier _userStateNotifier;

  HrRequestsBloc(this._hrRequestService, this._userStateNotifier)
      : super(const HrRequestsState()) {
    on<HrRequestsInit>(_init);
  }

  Future<void> _init(HrRequestsInit event,
      Emitter<HrRequestsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final hrServiceDeskRequests = await _hrRequestService
          .getHrRequestsOfUser(_userStateNotifier.employeeId);
      hrServiceDeskRequests.sort((a, b) => b.requestedAt.compareTo(a.requestedAt));
      emit(state.copyWith(
          status: Status.success,
          hrServiceDeskRequests: hrServiceDeskRequests));
    } on Exception {
      emit(state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }
}
