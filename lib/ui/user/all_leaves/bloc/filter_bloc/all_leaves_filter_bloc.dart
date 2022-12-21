import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'all_leaves_filter_event.dart';
import 'all_leaves_filter_state.dart';

@Injectable()
class AllLeavesFilterBloc extends Bloc<AllLeavesFilterEvents, AllLeavesFilterState> {
  AllLeavesFilterBloc() : super(const AllLeavesFilterState()) {
    on<RemoveFilterEvent>(_onRemoveFilter);
    on<ApplyFilterEvent>(_onApplyFilter);
    on<LeaveTypeChangeEvent>(_onLeaveTypeFilterChange);
    on<LeaveStatusChangeEvent>(_onLeaveStatusFilterChange);
    on<StartDateChangeEvent>(_onStartDateChangeEvent);
    on<EndDateChangeEvent>(_onEndDateChangeEvent);
  }

  void _onRemoveFilter(
      RemoveFilterEvent event, Emitter<AllLeavesFilterState> emit) {
    emit(const AllLeavesFilterState(filterApplied: false));
  }

  void _onApplyFilter(
      ApplyFilterEvent event, Emitter<AllLeavesFilterState> emit) {
    if (state.filterByLeaveStatus.isEmpty &&
        state.filterByLeaveTypes.isEmpty &&
        state.filterStartDate == null &&
        state.filterEndDate == null) {
      emit(AllLeavesFilterState(
          filterApplied: false,
          filterEndDate: state.filterEndDate,
          filterStartDate: state.filterStartDate,
          filterByLeaveStatus: state.filterByLeaveStatus,
          filterByLeaveTypes: state.filterByLeaveTypes));
    } else {
      emit(AllLeavesFilterState(
          filterApplied: true,
          filterEndDate: state.filterEndDate,
          filterStartDate: state.filterStartDate,
          filterByLeaveStatus: state.filterByLeaveStatus,
          filterByLeaveTypes: state.filterByLeaveTypes));
    }
  }

  void _onLeaveTypeFilterChange(
      LeaveTypeChangeEvent event, Emitter<AllLeavesFilterState> emit) {
    List<int> leaveType = state.filterByLeaveTypes.toList();
    if (leaveType.contains(event.leaveType)) {
      leaveType.remove(event.leaveType);
    } else {
      leaveType.add(event.leaveType);
    }
    emit(AllLeavesFilterState(
        filterByLeaveTypes: leaveType,
        filterByLeaveStatus: state.filterByLeaveStatus,
        filterStartDate: state.filterStartDate,
        filterEndDate: state.filterEndDate,
        filterApplied: state.filterApplied));
  }

  void _onLeaveStatusFilterChange(
      LeaveStatusChangeEvent event, Emitter<AllLeavesFilterState> emit) {
    List<int> leaveStatus = state.filterByLeaveStatus.toList();
    if (leaveStatus.contains(event.leaveStatus)) {
      leaveStatus.remove(event.leaveStatus);
    } else {
      leaveStatus.add(event.leaveStatus);
    }
    emit(AllLeavesFilterState(
        filterByLeaveTypes: state.filterByLeaveTypes,
        filterByLeaveStatus: leaveStatus,
        filterStartDate: state.filterStartDate,
        filterEndDate: state.filterEndDate,
        filterApplied: state.filterApplied));
  }

  void _onStartDateChangeEvent(
      StartDateChangeEvent event, Emitter<AllLeavesFilterState> emit) {
    emit(AllLeavesFilterState(
        filterByLeaveTypes: state.filterByLeaveTypes,
        filterByLeaveStatus: state.filterByLeaveStatus,
        filterStartDate: event.startDate,
        filterEndDate: state.filterEndDate,
        filterApplied: state.filterApplied));
  }

  void _onEndDateChangeEvent(
      EndDateChangeEvent event, Emitter<AllLeavesFilterState> emit) {
    emit(AllLeavesFilterState(
        filterByLeaveTypes: state.filterByLeaveTypes,
        filterByLeaveStatus: state.filterByLeaveStatus,
        filterStartDate: state.filterStartDate,
        filterEndDate: event.endDate,
        filterApplied: state.filterApplied));
  }
}
