import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/paid_leave_service.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/user/upcoming_leaves/bloc/upcoming_leaves_bloc.dart';
import 'package:projectunity/ui/user/upcoming_leaves/bloc/upcoming_leaves_event.dart';
import 'package:projectunity/ui/user/upcoming_leaves/bloc/upcoming_leaves_state.dart';
import 'upcoming_leaves_view_bloc_test.mocks.dart';

@GenerateMocks(
    [PaidLeaveService, UserLeaveService, UserManager])
void main() {
  late PaidLeaveService userPaidLeaveService;
  late UserLeaveService userLeaveService;
  late UpcomingLeavesViewBloc upcomingLeavesViewBloc;
  late UserManager userManager;

  const employee = Employee(
    id: "123",
    roleType: 2,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "tester",
  );

  const leave = Leave(
      leaveId: "234",
      uid: "123",
      leaveType: 1,
      startDate: 300303,
      endDate: 500000,
      totalLeaves: 1.0,
      reason: 'leave reason',
      leaveStatus: 1,
      appliedOn: 1000,
      perDayDuration: [1]);

  const leaveCounts = LeaveCounts(paidLeaveCount: 12, usedLeaveCount: 6.0, remainingLeaveCount: 6.0);

  List<LeaveApplication> leaveApplications = [
    const LeaveApplication(employee: employee, leave: leave, leaveCounts: leaveCounts),
  ];

  setUp(() {
    userPaidLeaveService = MockPaidLeaveService();
    userManager = MockUserManager();
    userLeaveService = MockUserLeaveService();

    upcomingLeavesViewBloc = UpcomingLeavesViewBloc( userPaidLeaveService, userLeaveService, userManager);

    when(userManager.employeeId).thenReturn("123");
    when(userManager.employee).thenReturn(employee);
  });

  group("Upcoming leaves view bloc test", ()
  {
    test("fetch upcoming leave data failure test", () async {
      UpcomingLeaveViewFailureState failureState = UpcomingLeaveViewFailureState(error: firestoreFetchDataError);

      when(userLeaveService.getUserUsedLeaveCount("123")).thenThrow(Exception("Error"));
      when(userPaidLeaveService.getPaidLeaves()).thenThrow(Exception("Error"));
      when(userLeaveService.getAllLeavesOfUser("123")).thenThrow(Exception("Error"));

      upcomingLeavesViewBloc.add(UpcomingLeavesViewInitialLoadEvent());
      expect(upcomingLeavesViewBloc.stream, emitsInOrder([UpcomingLeaveViewLoadingState(), failureState]));
    });

    test("fetch upcoming leave data success test", () async {
      UpcomingLeaveViewSuccessState successState =
      UpcomingLeaveViewSuccessState(leaveApplications: leaveApplications);

      when(userLeaveService.getUserUsedLeaveCount("123")).thenAnswer((_) => Future.value(6.0));
      when(userPaidLeaveService.getPaidLeaves()).thenAnswer((_) => Future.value(12));
      when(userLeaveService.getUpcomingLeaves("123")).thenAnswer((_) => Future.value([leave]));

      upcomingLeavesViewBloc.add(UpcomingLeavesViewInitialLoadEvent());
      expect(upcomingLeavesViewBloc.stream, emitsInOrder([UpcomingLeaveViewLoadingState(), successState]));
    });

    test("remove leave application test", (){
      upcomingLeavesViewBloc.emit(UpcomingLeaveViewSuccessState(leaveApplications: leaveApplications));
      upcomingLeavesViewBloc.add(RemoveLeaveApplicationOnUpcomingLeavesEvent(leaveApplications.first));
      expect(upcomingLeavesViewBloc.stream, emits(
          UpcomingLeaveViewSuccessState(leaveApplications: const [])
      ));
    });

  });


}
