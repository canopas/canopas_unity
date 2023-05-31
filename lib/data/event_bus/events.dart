import 'package:event_bus/event_bus.dart';
import '../model/leave_application.dart';

EventBus eventBus = EventBus();

class LeaveUpdateEventListener {
  LeaveApplication leaveApplication;
  LeaveUpdateEventListener(this.leaveApplication);
}

class UpdateLeavesEvent {}

class EmployeeListUpdateEvent {}


