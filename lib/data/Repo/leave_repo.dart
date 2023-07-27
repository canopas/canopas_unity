import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton()
class LeaveRepo {
  final LeaveService _leaveService;
  final UserStateNotifier _userStateNotifier;
  final FirebaseCrashlytics _crashlytics;
  late BehaviorSubject<List<Leave>> _leavesController;
  StreamSubscription<List<Leave>>? _leavesStreamSubscription;

  LeaveRepo(this._leaveService, this._crashlytics, this._userStateNotifier) {
    _leavesController = BehaviorSubject<List<Leave>>();
    _leavesStreamSubscription = _leaveService.leaves.listen((value) {
      _leavesController.add(value);
    }, onError: (e, s) async {
      _leavesController.addError(e);
      await _crashlytics.recordError(e, s);
    });
  }

  Stream<List<Leave>> get leaves => _leavesController.stream;

  Stream<List<Leave>> get pendingLeaves =>
      _leavesController.stream.asyncMap((event) =>
          event.where((leave) => leave.status == LeaveStatus.pending).toList());

  Future<void> reset() async {
    _leavesController = BehaviorSubject<List<Leave>>();
    await _leavesStreamSubscription?.cancel();
    _leavesStreamSubscription = _leaveService.leaves.listen((value) {
      _leavesController.add(value);
    }, onError: (e, s) async {
      _leavesController.addError(e);
      await _crashlytics.recordError(e, s);
    });
  }

  Stream<List<Leave>> userLeaveRequest(String uid) =>
      _leaveService.userLeaveByStatus(
          uid: uid,
          status: LeaveStatus.pending,
          spaceId: _userStateNotifier.currentSpaceId!);

  Stream<List<Leave>> userLeaves(String uid) => _leavesController.stream
      .asyncMap((leaves) => leaves.where((leave) => leave.uid == uid).toList());

  Stream<List<Leave>> leaveByMonth(DateTime date) =>
      Rx.combineLatest2<List<Leave>, List<Leave>, List<Leave>>(
        _leaveService.monthlyLeaveByStartDate(
            year: date.year,
            month: date.month,
            spaceId: _userStateNotifier.currentSpaceId!).distinct(),
        _leaveService.monthlyLeaveByEndDate(
            year: date.year,
            month: date.month,
            spaceId: _userStateNotifier.currentSpaceId!).distinct(),
        (leavesByStartDate, leavesByEndDate) {
          List<Leave> mergedList = leavesByStartDate;
          mergedList.addAll(leavesByEndDate.where((endDateLeave) =>
              !leavesByEndDate.any((startDateLeave) =>
                  startDateLeave.leaveId == endDateLeave.leaveId)));
          return mergedList;
        },
      ).distinct();

  @disposeMethod
  Future<void> dispose() async {
    await _leavesController.close();
    await _leavesStreamSubscription?.cancel();
  }
}
