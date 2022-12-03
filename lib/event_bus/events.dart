import 'package:event_bus/event_bus.dart';
import '../model/employee/employee.dart';
import '../model/leave/leave.dart';

EventBus eventBus = EventBus();

class LeaveUpdateEventListener {
  Leave leave;
  LeaveUpdateEventListener(this.leave);
}