import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'user_home_event.dart';
import 'user_home_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/provider/user_state.dart';
import '../../../../../data/services/leave_service.dart';

@Injectable()
class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final UserStateNotifier _userManager;
  final LeaveService _leaveService;
  StreamSubscription? _leaveRequestStreamSubscription;

  UserHomeBloc(this._userManager, this._leaveService)
      : super(UserHomeInitialState()) {
    on<ShowLoading>(_showLoading);
    on<ShowError>(_showError);
    on<UpdateLeaveRequest>(_updateLeaveRequest);
    add(ShowLoading());
    _leaveRequestStreamSubscription = _leaveService
        .getRequestedLeaveSnapshot(_userManager.employeeId)
        .listen((request) {
      add(UpdateLeaveRequest(request));
    }, onError: (error, _) {
      add(ShowError(firestoreFetchDataError));
    });
  }

  void _updateLeaveRequest(
      UpdateLeaveRequest event, Emitter<UserHomeState> emit) {
    emit(UserHomeSuccessState(requests: event.requests));
  }

  void _showError(ShowError event, Emitter<UserHomeState> emit) {
    emit(UserHomeErrorState(error: event.error));
  }

  void _showLoading(
      ShowLoading event, Emitter<UserHomeState> emit) {
    emit(UserHomeLoadingState());
  }

  @override
  Future<void> close() async {
    await _leaveRequestStreamSubscription?.cancel();
    return super.close();
  }
}
