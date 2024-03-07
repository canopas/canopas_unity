import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/invitation/invitation.dart';

part 'member_list_state.freezed.dart';

@freezed
class AdminMembersState with _$AdminMembersState {
  const factory AdminMembersState(
       {@Default([])  List<Employee> activeMembers,
        @Default([])  List<Employee> inactiveMembers,
        @Default([])  List<Invitation> invitation,
        @Default([])  List<int> expanded,
        @Default(Status.initial) Status memberFetchStatus,
        @Default(Status.initial) Status invitationFetchStatus,
        String? error
  }) = _AdminMembersState;
}



// class AdminMembersState extends Equatable {
//   final List<Employee> activeMembers;
//   final List<Employee> inactiveMembers;
//   final List<Invitation> invitation;
//   final List<int> expanded;
//   final Status memberFetchStatus;
//   final Status invitationFetchStatus;
//   final String? error;
//
//   const AdminMembersState(
//       {this.activeMembers = const [],
//       this.inactiveMembers = const [],
//       this.invitation = const [],
//         this.expanded = const [],
//       this.memberFetchStatus = Status.initial,
//       this.invitationFetchStatus = Status.initial,
//       this.error});
//
//   AdminMembersState copyWith(
//           {List<Employee>? activeMembers,
//           List<Employee>? inactiveMembers,
//           List<Invitation>? invitation,
//             List<int>? expanded,
//           Status? memberFetchStatus,
//           Status? invitationFetchStatus,
//           String? error}) =>
//       AdminMembersState(
//         activeMembers: activeMembers ?? this.activeMembers,
//         inactiveMembers: inactiveMembers ?? this.inactiveMembers,
//         memberFetchStatus: memberFetchStatus ?? this.memberFetchStatus,
//         expanded: expanded?? this.expanded,
//         invitationFetchStatus:
//             invitationFetchStatus ?? this.invitationFetchStatus,
//         invitation: invitation ?? this.invitation,
//         error: error,
//       );
//
//   @override
//   List<Object?> get props => [
//         activeMembers,
//         inactiveMembers,
//         invitation,
//         memberFetchStatus,
//         invitationFetchStatus,
//     expanded,
//         error
//       ];
// }
