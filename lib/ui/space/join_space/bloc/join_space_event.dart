import 'package:equatable/equatable.dart';
import 'package:projectunity/data/model/space/space.dart';

class JoinSpaceEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class JoinSpaceInitialFetchEvent extends JoinSpaceEvents {}

class SelectSpaceEvent extends JoinSpaceEvents {
  final Space space;

  SelectSpaceEvent({required this.space});
}

class JoinRequestedSpaceEvent extends JoinSpaceEvents {
  final Space space;

  JoinRequestedSpaceEvent({required this.space});
}

class SelectInvitationEvent extends JoinSpaceEvents {
  final Invocation invitation;

  SelectInvitationEvent({required this.invitation});
}