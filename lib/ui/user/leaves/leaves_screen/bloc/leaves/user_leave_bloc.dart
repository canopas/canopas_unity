import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/model/leave/leave.dart';
import '../../../../../../data/provider/user_state.dart';
import '../../../../../../data/services/leave_service.dart';

@Injectable()
class UserLeaveBloc extends Bloc<UserLeaveEvents, UserLeaveState> {
  final LeaveService _leaveService;
  final UserStateNotifier _userManager;
  late StreamSubscription _streamSubscription;
  late List<Leave> allLeaves = [];

  UserLeaveBloc(this._userManager, this._leaveService)
      : super(UserLeaveState()) {
    on<UserLeavesShowLeavesChangesEvent>(_showLeavesChanges);
    on<UserLeavesShowErrorEvent>(_showError);
    on<ChangeYearEvent>(_showLeaveByYear);
    _streamSubscription = _leaveService
        .leaveDBSnapshotOfUser(_userManager.employeeId)
        .listen((leaves) {
      allLeaves = leaves;
      add(UserLeavesShowLeavesChangesEvent());
    }, onError: (error, _) {
      add(UserLeavesShowErrorEvent(firestoreFetchDataError));
    });
  }

  void _showLeavesChanges(
      UserLeavesShowLeavesChangesEvent event, Emitter<UserLeaveState> emit) {
    emit(state.copyWith(
        status: Status.success,
        leaves: _getSelectedYearLeaveWithSortByDate(state.selectedYear)));
  }


  void _showError(
      UserLeavesShowErrorEvent event, Emitter<UserLeaveState> emit) {
    emit(state.copyWith(status: Status.error, error: event.error));
  }

  List<Leave> _getSelectedYearLeaveWithSortByDate(int year) {
    final List<Leave> leaves = allLeaves
        .where((leave) =>
            leave.startDate.year == year ||
            leave.endDate.year == year)
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
    await _streamSubscription.cancel();
    allLeaves.clear();
    return super.close();
  }
}
