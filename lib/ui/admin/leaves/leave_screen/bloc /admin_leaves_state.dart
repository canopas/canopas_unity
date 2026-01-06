import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave_application.dart';
import '../../../../../data/model/employee/employee.dart';

class AdminLeavesState extends Equatable {
  final Status leavesFetchStatus;
  final Status fetchMoreData;
  final Status membersFetchStatus;
  final String? error;
  final List<Employee> members;
  final Map<DateTime, List<LeaveApplication>> leaveApplicationMap;
  final Employee? selectedMember;

  const AdminLeavesState({
    this.leavesFetchStatus = Status.initial,
    this.membersFetchStatus = Status.initial,
    this.error,
    this.fetchMoreData = Status.initial,
    int? selectedYear,
    this.leaveApplicationMap = const {},
    this.members = const [],
    this.selectedMember,
  });

  AdminLeavesState copyWith({
    Status? fetchMoreData,
    Status? leavesFetchStatus,
    Status? membersFetchStatus,
    String? error,
    List<Employee>? members,
    Map<DateTime, List<LeaveApplication>>? leaveApplicationMap,
    Employee? selectedMember,
    bool assignSelectedEmployeeNull = false,
  }) => AdminLeavesState(
    selectedMember:
        selectedMember ??
        (assignSelectedEmployeeNull ? null : this.selectedMember),
    leaveApplicationMap: leaveApplicationMap ?? this.leaveApplicationMap,
    members: members ?? this.members,
    membersFetchStatus: membersFetchStatus ?? this.membersFetchStatus,
    leavesFetchStatus: leavesFetchStatus ?? this.leavesFetchStatus,
    fetchMoreData: fetchMoreData ?? this.fetchMoreData,
    error: error,
  );

  @override
  List<Object?> get props => [
    membersFetchStatus,
    fetchMoreData,
    leavesFetchStatus,
    error,
    leaveApplicationMap,
    members,
    selectedMember,
  ];
}
