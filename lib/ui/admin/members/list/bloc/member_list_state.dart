import 'package:equatable/equatable.dart';

import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/invitation/invitation.dart';

class AdminMembersState extends Equatable {
  final List<Employee> members;
  final List<Invitation> invitation;
  final Status fetchMemberStatus;
  final Status fetchInvitationStatus;
  final String? error;

  const AdminMembersState({
    this.error,
    this.members = const [],
    this.invitation = const [],
    this.fetchInvitationStatus = Status.initial,
    this.fetchMemberStatus = Status.initial,
  });

  AdminMembersState copyWith(
          {List<Employee>? members,
          List<Invitation>? invitation,
          Status? fetchMemberStatus,
          Status? fetchInvitationStatus,
          String? error}) =>
      AdminMembersState(
          error: error,
          invitation: invitation ?? this.invitation,
          members: members ?? this.members,
          fetchInvitationStatus: fetchInvitationStatus ?? this.fetchInvitationStatus,
          fetchMemberStatus: fetchMemberStatus ?? this.fetchMemberStatus);

  @override
  List<Object?> get props =>
      [error, members, invitation, fetchInvitationStatus, fetchMemberStatus];
}
