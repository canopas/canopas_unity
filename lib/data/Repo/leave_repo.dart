import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/services/leave_service.dart';


@LazySingleton()
class LeaveRepo{
  final LeaveService _leaveService;
  final _leaveController = StreamController<List<Leave>>();
  late final StreamSubscription<List<Leave>>? _leaveStreamSubscription;

  LeaveRepo(this._leaveService){
    _leaveStreamSubscription = _leaveService.leaveRequests.listen((value) {
      _leaveController.add(value);
    },
    );
  }

  Stream<List<Leave>> get leaves => _leaveController.stream.asBroadcastStream(
   
  );


  Future<void> disconnect() async {
    await _leaveStreamSubscription?.cancel();
    await _leaveController.close();
  }
}