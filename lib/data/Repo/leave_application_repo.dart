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
  final _leaveController = StreamController<List<Leave>>();
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

  Stream<List<Leave>> get leaves => _leaveController.stream.asBroadcastStream();
  Stream<List<Employee>> get employees => _employeeController.stream.asBroadcastStream();



  Future<void> disconnect() async {
    await leaveStreamSubscription?.cancel();
    await _leaveController.close();
    await employeeStreamSubscription?.cancel();
    await _employeeController.close();
  }

}
