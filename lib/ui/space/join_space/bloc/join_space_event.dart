import 'package:equatable/equatable.dart';

class JoinSpaceEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class JoinSpaceInitialFetchEvent extends JoinSpaceEvents {

}

class SelectSpaceEvent extends JoinSpaceEvents {
    final String spaceId;
    SelectSpaceEvent({required this.spaceId});
}

