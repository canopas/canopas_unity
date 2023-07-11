import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import '../../model/employee/employee.dart';
import '../../model/leave/leave.dart';
import '../../model/leave_application.dart';

Stream<List<LeaveApplication>> getLeaveApplicationStream(
    {required Stream<List<Leave>> leaveStream,
    required Stream<List<Employee>> membersStream}) {
  return Rx.combineLatest2(
      leaveStream,
      membersStream,
      (List<Leave> leaves, List<Employee> members) =>
          getLeaveApplicationFromLeaveEmployee(
              leaves: leaves, members: members));
}

List<LeaveApplication> getLeaveApplicationFromLeaveEmployee(
    {required List<Leave> leaves, required List<Employee> members}) {
  return leaves
      .map((leave) {
        final employee =
            members.firstWhereOrNull((emp) => emp.uid == leave.uid);
        if (employee != null) {
          return LeaveApplication(leave: leave, employee: employee);
        }
        return null;
      })
      .whereNotNull()
      .toList();
}
