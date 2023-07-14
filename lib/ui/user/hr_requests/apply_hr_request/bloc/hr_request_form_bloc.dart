import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/hr_request/hr_request.dart';
import 'hr_request_form_events.dart';
import 'hr_request_form_states.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/provider/user_state.dart';
import '../../../../../data/services/hr_request_service.dart';

@Injectable()
class HrRequestFormBloc extends Bloc<HrRequestFormEvents, HrRequestFormState> {
  final UserStateNotifier _userStateNotifier;
  final HrRequestService _hrRequestService;

  HrRequestFormBloc(this._userStateNotifier, this._hrRequestService)
      : super(const HrRequestFormState()) {
    on<ChangeType>(_changeType);
    on<ChangeDescription>(_changeDescription);
    on<ApplyHrRequest>(_applyHrRequest);
  }

  void _changeType(ChangeType event, Emitter<HrRequestFormState> emit) {
    emit(state.copyWith(type: event.type));
  }

  void _changeDescription(
      ChangeDescription event, Emitter<HrRequestFormState> emit) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _applyHrRequest(
      ApplyHrRequest event, Emitter<HrRequestFormState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      if (state.isProvidedDataValid) {
        final hrRequest = HrRequest(
            id: _hrRequestService.generateNewId,
            type: state.type!,
            uid: _userStateNotifier.employeeId,
            description: state.description,
            requestedAt: DateTime.now());
        await _hrRequestService.setHrRequest(hrRequest);
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(error: fillDetailsError, status: Status.error));
      }
    } on Exception {
      emit(
          state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }
}
