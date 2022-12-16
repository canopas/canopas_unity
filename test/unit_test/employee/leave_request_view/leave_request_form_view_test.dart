import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/map_extension.dart';
import 'package:projectunity/core/utils/const/leave_time_constants.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:projectunity/ui/user/leave/applyLeave/bloc/leave_request_form_bloc/leave_request_view_bloc.dart';
import 'package:projectunity/ui/user/leave/applyLeave/bloc/leave_request_form_bloc/leave_request_view_events.dart';
import 'package:projectunity/ui/user/leave/applyLeave/bloc/leave_request_form_bloc/leave_request_view_states.dart';

import 'leave_request_form_view_test.mocks.dart';

@GenerateMocks([PaidLeaveService, UserLeaveService, UserManager, NavigationStackManager])
void main() {
  late PaidLeaveService paidLeaveService;
  late UserLeaveService userLeaveService;
  late UserManager userManager;
  late LeaveRequestBloc leaveRequestBloc;
  late NavigationStackManager navigationStackManager;


  LeaveCounts leaveCount =  const LeaveCounts(
      remainingLeaveCount: 6.0, usedLeaveCount: 6.0, paidLeaveCount: 12);
  DateTime currentDate = DateTime.now().dateOnly;
  DateTime futureDate = DateTime.now().add(const Duration(days: 5)).dateOnly;



  group("Leave Request Form view test", () {

    setUp(() {
      paidLeaveService = MockPaidLeaveService();
      userLeaveService = MockUserLeaveService();
      userManager = MockUserManager();
      navigationStackManager = MockNavigationStackManager();
      leaveRequestBloc = LeaveRequestBloc(userManager, paidLeaveService,
          userLeaveService, navigationStackManager);

      when(userManager.employeeId).thenReturn("id");
    });



    test("fetch user leave count test", () {
      when(userLeaveService.getUserUsedLeaveCount('id')).thenAnswer((_) => Future(() => leaveCount.usedLeaveCount));
      when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future(() => leaveCount.paidLeaveCount));
      leaveRequestBloc.add(LeaveRequestFormInitialLoadEvent());
      expect(
          leaveRequestBloc.stream,
          emitsInOrder([
            LeaveRequestViewState(leaveCountStatus: LeaveRequestLeaveCountStatus.loading, startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:3}),
            LeaveRequestViewState(leaveCountStatus: LeaveRequestLeaveCountStatus.success, startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:3},leaveCounts: leaveCount),
          ]));
    });

    test("fetch user leave count failed test", () {
      when(userLeaveService.getUserUsedLeaveCount('id'))
          .thenThrow(Exception("Error"));
      when(paidLeaveService.getPaidLeaves()).thenThrow(Exception("Error"));
      leaveRequestBloc.add(LeaveRequestFormInitialLoadEvent());
      expect(
          leaveRequestBloc.stream,
          emitsInOrder([
            LeaveRequestViewState(leaveCountStatus: LeaveRequestLeaveCountStatus.loading, startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:3}),
            LeaveRequestViewState(leaveCountStatus: LeaveRequestLeaveCountStatus.failure, startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:3},error: firestoreFetchDataError),
          ]));
    });

    test("leave Type change test",(){
        leaveRequestBloc.add(LeaveRequestLeaveTypeChangeEvent(leaveType: 1));
        expect(leaveRequestBloc.stream, emits(LeaveRequestViewState(startDate: currentDate, endDate: currentDate, selectedDates: {currentDate:3},leaveType: 1)));
    });

    test('on apply leave fill data error test', () {
      leaveRequestBloc.add(LeaveRequestApplyLeaveEvent());
      expect(
          leaveRequestBloc.stream, emitsInOrder([
        LeaveRequestViewState(leaveRequestStatus: LeaveRequestStatus.loading, startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:3}),
        LeaveRequestViewState(leaveRequestStatus: LeaveRequestStatus.failure, startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:3},showTextFieldError: true,error: fillDetailsError),
      ]));
    });

    test("change reason test and apply leave button test", () {
      leaveRequestBloc.add(LeaveRequestReasonChangeEvent(reason: "reason"));
      expect(
          leaveRequestBloc.stream,
          emits(
            LeaveRequestViewState(startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:3},reason:"reason"),
          ));
    });

    test("date range per day selection change test", () {
      leaveRequestBloc.add(LeaveRequestUpdateLeaveOfTheDayEvent(date: currentDate, value: 0));
      expect(
          leaveRequestBloc.stream,
          emits(LeaveRequestViewState(startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:0},totalLeaveDays: 0),));
    });

    test('on apply leave minimum hour error test', (){
      leaveRequestBloc.add(LeaveRequestUpdateLeaveOfTheDayEvent(date: currentDate, value: 0));
      leaveRequestBloc.add(LeaveRequestReasonChangeEvent(reason: "reason"));
      leaveRequestBloc.add(LeaveRequestApplyLeaveEvent());
      expect(leaveRequestBloc.stream, emitsInOrder([
        LeaveRequestViewState(startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:0},totalLeaveDays: 0,),
        LeaveRequestViewState(startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:0},totalLeaveDays: 0,reason:"reason"),
        LeaveRequestViewState(leaveRequestStatus: LeaveRequestStatus.loading,totalLeaveDays: 0, startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:0},reason: "reason"),
        LeaveRequestViewState(leaveRequestStatus: LeaveRequestStatus.failure,totalLeaveDays: 0,startDate: currentDate,endDate: currentDate,selectedDates: {currentDate:0},error: applyMinimumHalfDay,reason: "reason"),
      ]));
    });

    test("start Date change test", () {
      Map<DateTime, int> updatedSelectedLeaves = {currentDate:3}.getSelectedLeaveOfTheDays(startDate: futureDate, endDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      leaveRequestBloc.add(LeaveRequestStartDateChangeEvents(startDate: futureDate));

      expect(
          leaveRequestBloc.stream,
          emits(LeaveRequestViewState(startDate: futureDate, endDate: currentDate, selectedDates: updatedSelectedLeaves,totalLeaveDays: totalDays)));
    });

    test("end Date change test", () {
      Map<DateTime, int> updatedSelectedLeaves = {currentDate:3}.getSelectedLeaveOfTheDays(endDate: futureDate, startDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      leaveRequestBloc.add(LeaveRequestEndDateChangeEvent(endDate:futureDate));

      expect(
          leaveRequestBloc.stream,
          emits(LeaveRequestViewState(endDate: futureDate, startDate: currentDate, selectedDates: updatedSelectedLeaves,totalLeaveDays:totalDays)));
    });

    test('on apply leave invalid leave date error test', (){
      Map<DateTime, int> updatedSelectedLeaves = {currentDate:3}.getSelectedLeaveOfTheDays(startDate: futureDate, endDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();
      leaveRequestBloc.add(LeaveRequestStartDateChangeEvents(startDate: futureDate));
      leaveRequestBloc.add(LeaveRequestReasonChangeEvent(reason: "reason"));
      leaveRequestBloc.add(LeaveRequestApplyLeaveEvent());

      expect(leaveRequestBloc.stream, emitsInOrder([
        LeaveRequestViewState(startDate: futureDate, endDate: currentDate, selectedDates: updatedSelectedLeaves ,totalLeaveDays: totalDays),
        LeaveRequestViewState(startDate: futureDate, endDate: currentDate, selectedDates: updatedSelectedLeaves ,totalLeaveDays: totalDays,reason: "reason"),
        LeaveRequestViewState(leaveRequestStatus: LeaveRequestStatus.loading,totalLeaveDays: totalDays,startDate: futureDate, endDate: currentDate, selectedDates: updatedSelectedLeaves,reason: "reason"),
        LeaveRequestViewState(leaveRequestStatus: LeaveRequestStatus.failure,totalLeaveDays: totalDays,startDate: futureDate, endDate: currentDate, selectedDates: updatedSelectedLeaves,error: invalidLeaveDateError,reason: "reason"),
      ]));
    });

    test('on apply success test', () async {

      Map<DateTime, int> updatedSelectedLeaves = {currentDate:3}.getSelectedLeaveOfTheDays(endDate: futureDate, startDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      final entries = updatedSelectedLeaves.entries.where((day) => day.value != noLeave);
      DateTime firstDate = entries.first.key;
      DateTime lastDate = entries.last.key;
      Map<DateTime,int> selectedDates = updatedSelectedLeaves..removeWhere((key, value) => key.isBefore(firstDate) || key.isAfter(lastDate));

      Leave leave = Leave(
        leaveId: "1234",
        uid: "id",
        leaveType: 0,
        startDate: firstDate.timeStampToInt,
        endDate: lastDate.timeStampToInt,
        totalLeaves: totalDays,
        reason: "reason",
        leaveStatus: pendingLeaveStatus,
        appliedOn: currentDate.timeStampToInt,
        perDayDuration: selectedDates.values.toList(),
      );

      when(userLeaveService.applyForLeave(leave)).thenAnswer((_)async{});

      leaveRequestBloc.add(LeaveRequestEndDateChangeEvent(endDate:futureDate));
      leaveRequestBloc.add(LeaveRequestReasonChangeEvent(reason: "reason"));
      leaveRequestBloc.add(LeaveRequestApplyLeaveEvent());


      expect(leaveRequestBloc.stream, emitsInOrder([
        LeaveRequestViewState(startDate: currentDate, endDate: futureDate, selectedDates: selectedDates,totalLeaveDays: totalDays),
        LeaveRequestViewState(startDate: currentDate, endDate: futureDate, selectedDates: selectedDates,totalLeaveDays: totalDays,reason: "reason"),
        LeaveRequestViewState(startDate: currentDate, endDate: futureDate, selectedDates: selectedDates,totalLeaveDays: totalDays,reason: "reason",leaveRequestStatus: LeaveRequestStatus.loading),
        LeaveRequestViewState(startDate: currentDate, endDate: futureDate, selectedDates: selectedDates,totalLeaveDays: totalDays,reason: "reason",leaveRequestStatus: LeaveRequestStatus.success),
      ]));

      const navState = NavStackItem.userAllLeaveState();

      await untilCalled(navigationStackManager.pop());
      await untilCalled(navigationStackManager.push(navState));
      verify(navigationStackManager.pop()).called(1);
      verify(navigationStackManager.push(navState)).called(1);

    });

    tearDownAll((){
      leaveRequestBloc.close();
    });

  });


}
