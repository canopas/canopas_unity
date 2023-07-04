import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton()
class LeaveRepo {
  final LeaveService _leaveService;
  BehaviorSubject<List<Leave>> _leavesController = BehaviorSubject<List<Leave>>();
  StreamSubscription<List<Leave>>? _leavesStreamSubscription;

  LeaveRepo(this._leaveService) {
    _leavesStreamSubscription = _leaveService.leaves.listen((value) {
        _leavesController.add(value);
      },
    );
  }

  Stream<List<Leave>> get pendingLeaves =>
      _leavesController.stream.asyncMap((event) =>
          event.where((leave) => leave.status == LeaveStatus.pending).toList());

  Stream<List<Leave>> absence(DateTime date) =>
      _leavesController.stream.asyncMap((event) {
        final list = event
            .where((leave) => leave.status == LeaveStatus.approved)
            .toList();
        return list;
      });

  Future<void> reset() async {
    if (!_leavesController.isClosed) {
      await _leavesController.close();
    }
    _leavesController = BehaviorSubject<List<Leave>>();
    await _leavesStreamSubscription?.cancel();
    _leavesStreamSubscription = _leaveService.leaves.listen(
      (value) {
        _leavesController.add(value);
      },
    );
  }

  @disposeMethod
  Future<void> dispose() async {
    await _leavesStreamSubscription?.cancel();
    await _leavesController.close();
  }
}
