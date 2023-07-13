import 'package:equatable/equatable.dart';

abstract class SpaceUserState extends Equatable {}

class SpaceUserErrorState extends SpaceUserState {
  final String error;

  SpaceUserErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

class SpaceUserInitialState extends SpaceUserState {
  @override
  List<Object?> get props => [];
}

class SpaceUserRevokeAccessState extends SpaceUserState {
  @override
  List<Object?> get props => [];
}
