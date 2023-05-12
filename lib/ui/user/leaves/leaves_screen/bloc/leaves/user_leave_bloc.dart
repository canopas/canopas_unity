import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';
import '../../../../../../data/core/exception/error_const.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/event_bus/events.dart';
import '../../../../../../data/model/leave/leave.dart';
import '../../../../../../data/provider/user_data.dart';
import '../../../../../../data/services/leave_service.dart';

@Injectable()
class UserLeaveBloc extends Bloc<UserLeaveEvents, UserLeaveState> {
  final LeaveService _leaveService;
  final UserManager _userManager;
  late StreamSubscription? _streamSubscription;
  late List<Leave> allLeaves = [];

  UserLeaveBloc(this._userManager, this._leaveService)
      : super(UserLeaveState()) {
    on<FetchUserLeaveEvent>(_fetchLeaves);
    on<ChangeYearEvent>(_showLeaveByYear);
    _streamSubscription = eventBus.on<CancelLeaveByUser>().listen((event) {
      add(FetchUserLeaveEvent());
    });
  }

  Future<void> _fetchLeaves(
      FetchUserLeaveEvent event, Emitter<UserLeaveState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      allLeaves =
          await _leaveService.getAllLeavesOfUser(_userManager.employeeId);
      final List<Leave> leaves =
          _getSelectedYearLeaveWithSortByDate(state.selectedYear);
      emit(state.copyWith(status: Status.success, leaves: leaves));
    } on Exception {
      emit(
          state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }

  List<Leave> _getSelectedYearLeaveWithSortByDate(int year) {
    final List<Leave> leaves = allLeaves
        .where((leave) =>
            leave.startDate.toDate.year == year ||
            leave.endDate.toDate.year == year)
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
    await _streamSubscription?.cancel();
    allLeaves.clear();
    return super.close();
  }
}
