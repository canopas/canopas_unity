import 'package:equatable/equatable.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/invitation/invitation.dart';

class AdminMembersState extends Equatable {
  final List<Employee> members;
  final List<Invitation> invitation;
  final Status memberFetchStatus;
  final Status invitationFetchStatus;
  final String? error;

  const AdminMembersState(
      {this.members = const [],
      this.invitation = const [],
      this.memberFetchStatus = Status.initial,
      this.invitationFetchStatus = Status.initial,
      this.error});

  AdminMembersState copyWith(
          {List<Employee>? members,
          List<Invitation>? invitation,
          Status? memberFetchStatus,
          Status? invitationFetchStatus,
          String? error}) =>
      AdminMembersState(
        members: members ?? this.members,
        memberFetchStatus: memberFetchStatus ?? this.memberFetchStatus,
        invitationFetchStatus:
            invitationFetchStatus ?? this.invitationFetchStatus,
        invitation: invitation ?? this.invitation,
        error: error,
      );

  @override
  List<Object?> get props =>
      [members, invitation, memberFetchStatus, invitationFetchStatus, error];
}
