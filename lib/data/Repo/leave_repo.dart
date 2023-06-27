import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton()
class LeaveRepo {
  final LeaveService _leaveService;
  final _pendingLeaveController = BehaviorSubject<List<Leave>>();
  final _absenceLeaveController= BehaviorSubject<List<Leave>>();
  late final StreamSubscription<List<Leave>>? _pendingLeaveStreamSubscription;
  late final StreamSubscription<List<Leave>>? _absenceLeaveStreamSubscription;


  LeaveRepo(this._leaveService) {
    _pendingLeaveStreamSubscription = _leaveService.leaveRequests.listen(
      (value) {
        _pendingLeaveController.add(value);
      },
    );
    _absenceLeaveStreamSubscription= _leaveService.absences.listen((value) {
      _absenceLeaveController.add(value);
    });

  }

  Stream<List<Leave>> get pendingLeaves => _pendingLeaveController.stream.asBroadcastStream();
  Stream<List<Leave>>  absence(DateTime date) => _absenceLeaveController.stream.asyncMap((event) {
    final list=   event.where((leave) => (((leave.startDate.dateOnly.month == date.month &&
        leave.startDate.dateOnly.year == date.year) ||
        (leave.endDate.dateOnly.month == date.month &&
            leave.endDate.dateOnly.year == date.year)) )).toList();
    return list;
  });

  @disposeMethod
  Future<void> close()async{
    _pendingLeaveStreamSubscription?.cancel();
    _absenceLeaveStreamSubscription?.cancel();
    _pendingLeaveController.close();
    _absenceLeaveController.close();
  }

}
