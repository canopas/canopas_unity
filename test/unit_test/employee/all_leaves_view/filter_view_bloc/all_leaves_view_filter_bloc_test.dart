import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/ui/user/all_leaves/bloc/filter_bloc/all_leaves_filter_event.dart';
import 'package:projectunity/ui/user/all_leaves/bloc/filter_bloc/all_leaves_filter_state.dart';
import 'package:projectunity/ui/user/all_leaves/bloc/filter_bloc/all_leaves_filter_bloc.dart';

void main() {
  AllLeavesFilterBloc employeeLeaveFilterBloc = AllLeavesFilterBloc();

  group("Employee Leave Filter Test", () {
    
    test("change leave type test", () {
      employeeLeaveFilterBloc.add(LeaveTypeChangeEvent(1));
      employeeLeaveFilterBloc.add(LeaveTypeChangeEvent(2));
      employeeLeaveFilterBloc.add(LeaveTypeChangeEvent(1));
      employeeLeaveFilterBloc.add(LeaveTypeChangeEvent(2));
      expect(
          employeeLeaveFilterBloc.stream,
          emitsInOrder([
            const AllLeavesFilterState(filterByLeaveTypes: [1]),
            const AllLeavesFilterState(filterByLeaveTypes: [1,2]),
            const AllLeavesFilterState(filterByLeaveTypes: [2]),
            const AllLeavesFilterState()
          ]));
    });

    test("change leave status test", () {
      employeeLeaveFilterBloc.add(LeaveStatusChangeEvent(1));
      employeeLeaveFilterBloc.add(LeaveStatusChangeEvent(0));
      employeeLeaveFilterBloc.add(LeaveStatusChangeEvent(1));
      employeeLeaveFilterBloc.add(LeaveStatusChangeEvent(0));
      expect(
          employeeLeaveFilterBloc.stream,
          emitsInOrder([
            const AllLeavesFilterState(filterByLeaveStatus: [1]),
            const AllLeavesFilterState(filterByLeaveStatus: [1,0]),
            const AllLeavesFilterState(filterByLeaveStatus: [0]),
            const AllLeavesFilterState()
          ]));
    });

    test("change start date test", () {
      DateTime startDate = DateTime.now();
      employeeLeaveFilterBloc.add(StartDateChangeEvent(startDate));
      employeeLeaveFilterBloc.add(StartDateChangeEvent(null));
      expect(
          employeeLeaveFilterBloc.stream,
          emitsInOrder([
            AllLeavesFilterState(filterStartDate: startDate),
            const AllLeavesFilterState()
          ]));
    });

    test("change end date test", () {
      DateTime endDate = DateTime.now();
      employeeLeaveFilterBloc.add(EndDateChangeEvent(endDate));
      employeeLeaveFilterBloc.add(EndDateChangeEvent(null));
      expect(
          employeeLeaveFilterBloc.stream,
          emitsInOrder([
            AllLeavesFilterState(filterEndDate: endDate),
            const AllLeavesFilterState()
          ]));
    });

    test("appLy and remove filter test", () {
      final DateTime date = DateTime.now();
      employeeLeaveFilterBloc.add(LeaveTypeChangeEvent(1));
      employeeLeaveFilterBloc.add(LeaveStatusChangeEvent(2));
      employeeLeaveFilterBloc.add(StartDateChangeEvent(date));
      employeeLeaveFilterBloc.add(EndDateChangeEvent(date));
      employeeLeaveFilterBloc.add(ApplyFilterEvent());
      employeeLeaveFilterBloc.add(LeaveTypeChangeEvent(1));
      employeeLeaveFilterBloc.add(RemoveFilterEvent());
      expect(
          employeeLeaveFilterBloc.stream,
          emitsInOrder([
            const AllLeavesFilterState(filterByLeaveTypes: [1]),
            const AllLeavesFilterState(filterByLeaveTypes: [1],filterByLeaveStatus: [2]),
             AllLeavesFilterState(filterByLeaveTypes: const [1],filterByLeaveStatus: const [2],filterStartDate: date,),
             AllLeavesFilterState(filterByLeaveTypes: const [1],filterByLeaveStatus: const [2],filterStartDate: date,filterEndDate: date),
             AllLeavesFilterState(filterByLeaveTypes: const [1],filterByLeaveStatus: const [2],filterStartDate: date,filterEndDate: date,filterApplied: true),
             AllLeavesFilterState(filterByLeaveTypes: const [],filterByLeaveStatus: const [2],filterStartDate: date,filterEndDate: date,filterApplied: true),
            const AllLeavesFilterState()
          ]));
    });

  });
}
