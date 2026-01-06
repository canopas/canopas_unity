import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/invitation/invitation.dart';

part 'member_list_state.freezed.dart';

@freezed
abstract class AdminMembersState with _$AdminMembersState {
  const factory AdminMembersState({
    @Default([]) List<Employee> activeMembers,
    @Default([]) List<Employee> inactiveMembers,
    @Default([]) List<Invitation> invitation,
    @Default([]) List<int> expanded,
    @Default(Status.initial) Status memberFetchStatus,
    @Default(Status.initial) Status invitationFetchStatus,
    String? error,
  }) = _AdminMembersState;
}
