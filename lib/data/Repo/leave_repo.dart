import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton()
class LeaveRepo {
  final LeaveService _leaveService;
  BehaviorSubject<List<Leave>>? _leavesController =
      BehaviorSubject<List<Leave>>();
  StreamSubscription<List<Leave>>? _leavesStreamSubscription;

  LeaveRepo(this._leaveService) {
    // _leavesStreamSubscription = _leaveService.leaves.listen((value) {
    //   _leavesController.add(value);
    // }, onError: (e, s) async {
    //   _leavesController.addError(e);
    //   await FirebaseCrashlytics.instance.recordError(e, s);
    // });
  }

  Stream<List<Leave>> get leaves => _leavesController!.stream;

  Stream<List<Leave>> get pendingLeaves =>
      _leavesController!.stream.asyncMap((event) =>
          event.where((leave) => leave.status == LeaveStatus.pending).toList());

  Stream<List<Leave>> absence(DateTime date) =>
      _leavesController!.stream.asyncMap((event) => event
          .where((leave) =>
              leave.status == LeaveStatus.approved &&
              ((leave.startDate.month == date.month &&
                      leave.startDate.year == date.year) ||
                  (leave.endDate.month == date.month &&
                      leave.endDate.year == date.year)))
          .toList());

  Future<void> reset() async {
    if (_leavesStreamSubscription != null) {
      _leavesStreamSubscription!.cancel();
    }
    // if(_leavesController!=null){
    //   _leavesController=null;
    // }
//
    print(_leavesController?.isClosed);
    // await _leavesStreamSubscription?.cancel();

    _leavesStreamSubscription = _leaveService.leaves.listen((value) {
      _leavesController!.add(value);
    }, onError: (e, s) async {
      _leavesController!.addError(e);
      await FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  Stream<List<Leave>> userLeaveRequest(String uid) =>
      _leavesController!.stream.asyncMap((leaves) => leaves
          .where((leave) =>
              leave.uid == uid && leave.status == LeaveStatus.pending)
          .toList());

  Stream<List<Leave>> userLeaves(String uid) => _leavesController!.stream
      .asyncMap((leaves) => leaves.where((leave) => leave.uid == uid).toList());

  Future<void> cancel() async {
    await _leavesStreamSubscription?.cancel();
  }

  @disposeMethod
  Future<void> dispose() async {
    await _leavesStreamSubscription?.cancel();
    await _leavesController!.close();
  }
}
