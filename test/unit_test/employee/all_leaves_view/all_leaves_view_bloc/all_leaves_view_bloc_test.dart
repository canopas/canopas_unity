import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:projectunity/ui/user/all_leaves/bloc/leaves_bloc/all_leaves_bloc.dart';
import 'package:projectunity/ui/user/all_leaves/bloc/leaves_bloc/all_leaves_event.dart';
import 'package:projectunity/ui/user/all_leaves/bloc/leaves_bloc/all_leaves_state.dart';
import 'all_leaves_view_bloc_test.mocks.dart';

@GenerateMocks([PaidLeaveService, UserLeaveService, UserManager])
void main() {
  late PaidLeaveService userPaidLeaveService;
  late UserLeaveService userLeaveService;
  late AllLeavesViewBloc allLeavesViewBloc;
  late UserManager userManager;

  final employee = Employee(
      id: "123",
      roleType: 2,
      name: "test",
      employeeId: "103",
      email: "abc@gmail.com",
      designation: "tester",
      dateOfJoining: DateTime.now().dateOnly.timeStampToInt);

  DateTime currentDate = DateTime.now().dateOnly;

  final leave = Leave(
      leaveId: "234",
      uid: "123",
      leaveType: 1,
      startDate: currentDate.timeStampToInt,
      endDate: currentDate.timeStampToInt,
      totalLeaves: 1.0,
      reason: 'reason',
      leaveStatus: 1,
      appliedOn: currentDate.timeStampToInt,
      perDayDuration: const [3]);

  const leaveCounts = LeaveCounts(
      paidLeaveCount: 12, usedLeaveCount: 6.0, remainingLeaveCount: 6.0);

  List<LeaveApplication> leaveApplications = [
    LeaveApplication(
        employee: employee, leave: leave, leaveCounts: leaveCounts),
  ];

  AllLeavesViewSuccessState successState = AllLeavesViewSuccessState(
      leaveApplications: leaveApplications);
  AllLeavesViewSuccessState emptyState = AllLeavesViewSuccessState(
      leaveApplications: const []);
  AllLeavesViewLoadingState loadingState = AllLeavesViewLoadingState();

  group("All leaves screen fetch data and navigation test", () {

    setUp(() {
      userPaidLeaveService = MockPaidLeaveService();
      userManager = MockUserManager();
      userLeaveService = MockUserLeaveService();

      allLeavesViewBloc = AllLeavesViewBloc(userManager,
          userLeaveService, userPaidLeaveService);

      when(userManager.employeeId).thenReturn("123");
      when(userManager.employee).thenReturn(employee);
    });

    test("fetch data failure test", () async {
      AllLeavesViewFailureState failureState =
          AllLeavesViewFailureState(error: firestoreFetchDataError);

      when(userLeaveService.getUserUsedLeaveCount("123"))
          .thenThrow(Exception("Error"));
      when(userPaidLeaveService.getPaidLeaves()).thenThrow(Exception("Error"));
      when(userLeaveService.getAllLeavesOfUser("123"))
          .thenThrow(Exception("Error"));

      allLeavesViewBloc.add(AllLeavesInitialLoadEvent());
      expect(
          allLeavesViewBloc.stream, emitsInOrder([loadingState, failureState]));
    });

    test("fetch data success test", () async {
      when(userLeaveService.getUserUsedLeaveCount("123"))
          .thenAnswer((_) => Future(() => 6.0));
      when(userPaidLeaveService.getPaidLeaves())
          .thenAnswer((_) => Future(() => 12));
      when(userLeaveService.getAllLeavesOfUser("123"))
          .thenAnswer((_) => Future(() => [leave]));
      allLeavesViewBloc.add(AllLeavesInitialLoadEvent());
      expect(
          allLeavesViewBloc.stream, emitsInOrder([loadingState, successState]));
    });

    test("remove leave application test", (){
      allLeavesViewBloc.emit(successState);
      allLeavesViewBloc.add(RemoveLeaveApplicationOnAllLeaveViewEvent(leaveApplications.first));
      expect(allLeavesViewBloc.stream, emits(emptyState));
    });



  group("All leaves filter tests", () {
    setUp(() {
      userPaidLeaveService = MockPaidLeaveService();
      userManager = MockUserManager();
      userLeaveService = MockUserLeaveService();

      allLeavesViewBloc = AllLeavesViewBloc(userManager,
          userLeaveService, userPaidLeaveService);
      when(userManager.employeeId).thenReturn("123");
      when(userManager.employee).thenReturn(employee);
      when(userLeaveService.getUserUsedLeaveCount("123"))
          .thenAnswer((_) => Future(() => 6.0));
      when(userPaidLeaveService.getPaidLeaves())
          .thenAnswer((_) => Future(() => 12));
      when(userLeaveService.getAllLeavesOfUser("123"))
          .thenAnswer((_) => Future(() => [leave]));

      allLeavesViewBloc.add(AllLeavesInitialLoadEvent());
    });

    test("leave type test when there leave type leave not exist", () {
      allLeavesViewBloc
          .add(ApplyFilterAllLeavesViewEvent(leaveType: const [4]));
      expect(allLeavesViewBloc.stream, emits(emptyState));
    });

    test("leave type test when there leave type leave exist", () {
      allLeavesViewBloc.emit(emptyState);
      allLeavesViewBloc.add(ApplyFilterAllLeavesViewEvent(
        leaveType: const [1],
      ));
      expect(allLeavesViewBloc.stream, emits(successState));
    });

    test("leave status test when there leave type status not exist", () {
      allLeavesViewBloc.add(ApplyFilterAllLeavesViewEvent(
        leaveStatus: const [2],
      ));
      expect(allLeavesViewBloc.stream, emits(emptyState));
    });

    test("leave status test when there leave type status exist", () {
      allLeavesViewBloc.emit(emptyState);
      allLeavesViewBloc.add(ApplyFilterAllLeavesViewEvent(
        leaveStatus: const [1],
      ));
      expect(allLeavesViewBloc.stream, emits(successState));
    });

    test("apply filter start-date is after end-date test ", () {
      allLeavesViewBloc.add(ApplyFilterAllLeavesViewEvent(
          startDate: currentDate.add(const Duration(days: 5)),
          endDate: currentDate));
      expect(allLeavesViewBloc.stream, emits(emptyState));
    });

    test("apply filter when startDate and endDate is not null ", () {
      allLeavesViewBloc.emit(emptyState);
      allLeavesViewBloc.add(ApplyFilterAllLeavesViewEvent(
          startDate: currentDate, endDate: currentDate));
      expect(allLeavesViewBloc.stream, emits(successState));
    });

    test(
        "apply filter when startDate and endDate is not null but its different",
        () {
      allLeavesViewBloc.add(ApplyFilterAllLeavesViewEvent(
          startDate: currentDate.add(const Duration(days: 5)),
          endDate: currentDate.add(const Duration(days: 5))));
      expect(allLeavesViewBloc.stream, emits(emptyState));
    });

    test(
        "apply filter when endDate is not null but startDate null and there is leave",
        () {
      allLeavesViewBloc.emit(emptyState);
      allLeavesViewBloc
          .add(ApplyFilterAllLeavesViewEvent(endDate: currentDate));
      expect(allLeavesViewBloc.stream, emits(successState));
    });

    test(
        "apply filter when endDate is not null but startDate null and there is not leave",
        () {
      allLeavesViewBloc.add(ApplyFilterAllLeavesViewEvent(
          endDate: currentDate.subtract(const Duration(days: 2))));
      expect(allLeavesViewBloc.stream, emits(emptyState));
    });

    test(
        "apply filter when startDate is not null but endDate null and there is leave",
        () {
      allLeavesViewBloc.emit(emptyState);
      allLeavesViewBloc
          .add(ApplyFilterAllLeavesViewEvent(startDate: currentDate));
      expect(allLeavesViewBloc.stream, emits(successState));
    });

    test(
        "apply filter when startDate is not null but endDate null and there is not leave",
        () {
      allLeavesViewBloc.add(ApplyFilterAllLeavesViewEvent(
          startDate: currentDate.add(const Duration(days: 2))));
      expect(allLeavesViewBloc.stream, emits(emptyState));
    });

    test("remove filter test", () {
      allLeavesViewBloc.emit(emptyState);
      allLeavesViewBloc.add(RemoveFilterAllLeavesViewEvent());
      expect(allLeavesViewBloc.stream, emits(successState));
    });
  });
});
}