import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton()
class LeaveRepo {
  final LeaveService _leaveService;
  final _leavesController = BehaviorSubject<List<Leave>>();
  late final StreamSubscription<List<Leave>> _leavesStreamSubscription;

  LeaveRepo(this._leaveService) {
    _leavesStreamSubscription = _leaveService.leaveRequests.listen(
      (value) {
        _leavesController.add(value);
      },
    );
  }

  reset() {
    _leavesStreamSubscription.cancel();
    _leavesStreamSubscription = _leaveService.leaveRequests.listen(
      (value) {
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

  @disposeMethod
  Future<void> close() async {
    _leavesStreamSubscription.cancel();
    _leavesController.close();
  }
}
