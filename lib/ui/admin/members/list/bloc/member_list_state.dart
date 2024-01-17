import 'package:equatable/equatable.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/invitation/invitation.dart';

class AdminMembersState extends Equatable {
  final List<Employee> activeMembers;
  final List<Employee> inactiveMembers;
  final List<Invitation> invitation;
  final Status memberFetchStatus;
  final Status invitationFetchStatus;
  final String? error;

  const AdminMembersState(
      {this.activeMembers = const [],
      this.inactiveMembers = const [],
      this.invitation = const [],
      this.memberFetchStatus = Status.initial,
      this.invitationFetchStatus = Status.initial,
      this.error});

  AdminMembersState copyWith(
          {List<Employee>? activeMembers,
          List<Employee>? inactiveMembers,
          List<Invitation>? invitation,
          Status? memberFetchStatus,
          Status? invitationFetchStatus,
          String? error}) =>
      AdminMembersState(
        activeMembers: activeMembers ?? this.activeMembers,
        inactiveMembers: inactiveMembers ?? this.inactiveMembers,
        memberFetchStatus: memberFetchStatus ?? this.memberFetchStatus,
        invitationFetchStatus:
            invitationFetchStatus ?? this.invitationFetchStatus,
        invitation: invitation ?? this.invitation,
        error: error,
      );

  @override
  List<Object?> get props => [
        activeMembers,
        inactiveMembers,
        invitation,
        memberFetchStatus,
        invitationFetchStatus,
        error
      ];
}
