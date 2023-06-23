import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../model/employee/employee.dart';
import '../model/leave/leave.dart';
import '../model/leave_application.dart';

@Injectable()
class LeaveApplicationRepo {
  final LeaveService leaveService;
  final EmployeeService employeeService;
  late ReplayConnectableStream<List<Leave>> leaveRC;
  late ReplayConnectableStream<List<Employee>> employeeRC;
  final _leaveController = StreamController<List<Leave>>();
  late final Stream<List<Leave>> leave$;

  Stream<List<Employee>> get employee$ => _employeeController.stream;
  final _employeeController = StreamController<List<Employee>>();
  late final StreamSubscription<List<Leave>>? leaveStreamSubscription;
  late final StreamSubscription<List<Employee>>? employeeStreamSubscription;

  LeaveApplicationRepo(this.leaveService, this.employeeService) {
    leaveStreamSubscription = leaveService.leaveRequests.listen((event) {
      _leaveController.add(event);
    });
    employeeStreamSubscription = employeeService.employees.listen((value) {
      _employeeController.add(value);
    });
  }

  Stream<List<Leave>> get leaves {
    return _leaveController.stream.asBroadcastStream(
        onCancel: (_) {
          print('leaveStreamSubscription is cancelled');
          leaveStreamSubscription?.cancel();
        },
        onListen: (_) {
          print('leaveStreamSubscription is resumed');

          leaveStreamSubscription?.resume();
        }
    );
  }


  Stream<List<Employee>> get employees {
    return _employeeController.stream.asBroadcastStream(
        onCancel: (_) {
          print('employeeStreamSubscription is cancelled');

          employeeStreamSubscription?.cancel();
        },
        onListen: (_) {
          print('employeeStreamSubscription is resumed');

          employeeStreamSubscription?.resume();
        }
    );
  }


  Future<void> disConnect() async {
    await leaveStreamSubscription?.cancel();
    await _leaveController.close();
    await employeeStreamSubscription?.cancel();
    await _employeeController.close();
  }


  // inal broadcastStream = stream.asBroadcastStream(
  //   onCancel: (subscription) {
  //     subscription.pause();
  //   },
  //   onListen: (subscription) {
  //     subscription.resume();
  //   },
  // );


  // Future<void> close() async {
  //   print('repo closed');
  //   await leaveStreamSubscription.cancel();
  //   await employeeStreamSubscription.cancel();
  //   print(
  //       'leavestreamSubscription in repo: ${leaveStreamSubscription.isPaused}');
  //   print('employeeStreamSubscription in repo: ${employeeStreamSubscription
  //       .isPaused}');
  // }
}
