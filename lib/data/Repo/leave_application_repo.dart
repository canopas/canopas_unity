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
class LeaveApplicationRepo extends Bloc {
  final LeaveService leaveService;
  final EmployeeService employeeService;
  late ReplayConnectableStream<List<Leave>> leaveRC;
  late ReplayConnectableStream<List<Employee>> employeeRC;
  final leave$ = BehaviorSubject<List<Leave>>();
  final employee$ = BehaviorSubject<List<Employee>>();
  late final StreamSubscription<List<Leave>> leaveStreamSubscription;
  late final StreamSubscription<List<Employee>> employeeStreamSubscription;

  LeaveApplicationRepo(this.leaveService, this.employeeService) : super(null) {
    leaveRC = leaveService.leaveRequests.publishReplay();
    leaveStreamSubscription = leaveRC.listen((event) {
      leave$.add(event);
    });
    employeeRC = employeeService.employees.publishReplay();
    employeeStreamSubscription = employeeRC.listen((value) {
      employee$.add(value);
    });
  }

  Stream<List<LeaveApplication>> get combineStreams {
    return Rx.combineLatest2(
        leaveService.leaveRequests, employeeService.employees,
        (List<Leave> leaves, List<Employee> employees) {
      return leaves
          .map((leave) {
            final employee =
                employees.firstWhereOrNull((emp) => emp.uid == leave.uid);
            if (employee == null) {
              return null;
            } else {
              return LeaveApplication(leave: leave, employee: employee);
            }
          })
          .whereNotNull()
          .toList();
    });
  }

  @override
  Future<void> close() async {
    super.close();
    await leaveStreamSubscription.cancel();
    await employeeStreamSubscription.cancel();
  }
}
