import 'package:equatable/equatable.dart';

abstract class CreateSpaceStates extends Equatable {}

class CreateSpaceInitialState extends CreateSpaceStates {
  @override
  List<Object?> get props => [];
}

class CreateSpaceLoadingState extends CreateSpaceStates {
  @override
  List<Object?> get props => [];
}

class CreateSpaceFailureState extends CreateSpaceStates {
  final String error;

  CreateSpaceFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class CreateSpaceSuccessState extends CreateSpaceStates {
  @override
  List<Object?> get props => [];
}
