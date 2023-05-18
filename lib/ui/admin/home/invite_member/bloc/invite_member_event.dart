import 'package:equatable/equatable.dart';


abstract class InvitationEvent extends Equatable {}

class AddEmailEvent extends InvitationEvent {
  final String query;

  AddEmailEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class InviteMemberEvent extends InvitationEvent {
  @override
  List<Object?> get props => [];
}
