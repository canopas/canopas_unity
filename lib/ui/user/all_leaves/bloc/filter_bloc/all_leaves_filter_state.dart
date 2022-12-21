import 'package:equatable/equatable.dart';

class AllLeavesFilterState extends Equatable{
  final List<int> filterByLeaveTypes;
  final List<int> filterByLeaveStatus;
  final DateTime? filterStartDate;
  final DateTime? filterEndDate;
  final bool filterApplied;

  const AllLeavesFilterState({
    this.filterByLeaveStatus = const [],
    this.filterByLeaveTypes = const [],
    this.filterStartDate,
    this.filterEndDate,
    this.filterApplied = false,
});

  @override
  List<Object?> get props => [filterByLeaveTypes,filterByLeaveStatus,filterEndDate,filterStartDate,filterApplied];
}