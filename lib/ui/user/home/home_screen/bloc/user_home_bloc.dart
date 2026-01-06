import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';
import '../../../../../data/repo/leave_repo.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/provider/user_state.dart';

@Injectable()
class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final UserStateNotifier _userManager;
  final LeaveRepo _leaveRepo;

  UserHomeBloc(this._userManager, this._leaveRepo)
    : super(UserHomeInitialState()) {
    on<UserHomeFetchLeaveRequest>(_fetchLeaveRequest);
  }

  Future<void> _fetchLeaveRequest(
    UserHomeFetchLeaveRequest event,
    Emitter<UserHomeState> emit,
  ) async {
    emit(UserHomeLoadingState());
    try {
      return emit.forEach(
        _leaveRepo.userLeaveRequest(_userManager.employeeId),
        onData: (List<Leave> requests) {
          requests.sort((a, b) => b.appliedOn.compareTo(a.appliedOn));
          return UserHomeSuccessState(requests: requests);
        },
        onError: (error, _) =>
            UserHomeErrorState(error: firestoreFetchDataError),
      );
    } on Exception {
      emit(UserHomeErrorState(error: firestoreFetchDataError));
    }
  }
}
