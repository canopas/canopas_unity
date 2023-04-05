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
