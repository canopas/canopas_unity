import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';
import '../../../../../../data/Repo/leave_repo.dart';
import '../../../../../../data/core/exception/error_const.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/model/leave/leave.dart';
import '../../../../../../data/provider/user_state.dart';

@Injectable()
class UserLeaveBloc extends Bloc<UserLeaveEvents, UserLeaveState> {
  final LeaveRepo _leaveRepo;
  final UserStateNotifier _userManager;
  late List<Leave> _allLeaves = [];

  UserLeaveBloc(this._userManager, this._leaveRepo) : super(UserLeaveState()) {
    on<FetchUserLeaveEvent>(_fetchLeaves);
    on<ChangeYearEvent>(_showLeaveByYear);
  }

  Future<void> _fetchLeaves(
      FetchUserLeaveEvent event, Emitter<UserLeaveState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      return emit.forEach(_leaveRepo.userLeaves(_userManager.employeeId),
          onData: (List<Leave> leaves) {
            _allLeaves = leaves.toList();
            return state.copyWith(
                status: Status.success,
                leaves:
                    _getSelectedYearLeaveWithSortByDate(state.selectedYear));
          },
          onError: (error, _) => state.copyWith(
              status: Status.error, error: firestoreFetchDataError));
    } on Exception {
      emit(
          state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }

  List<Leave> _getSelectedYearLeaveWithSortByDate(int year) {
    final List<Leave> leaves = _allLeaves
        .where((leave) =>
            leave.startDate.year == year || leave.endDate.year == year)
        .whereNotNull()
        .toList();
    leaves.sort((a, b) => b.startDate.compareTo(a.startDate));
    return leaves;
  }

  Future<void> _showLeaveByYear(
      ChangeYearEvent event, Emitter<UserLeaveState> emit) async {
    emit(state.copyWith(
        leaves: _getSelectedYearLeaveWithSortByDate(event.year),
        selectedYear: event.year));
  }

  @override
  Future<void> close() async {
    _allLeaves.clear();
    return super.close();
  }
}
