import 'package:equatable/equatable.dart';

abstract class CreateWorkSpaceStates extends Equatable {}

class CreateWorkSpaceInitialState extends CreateWorkSpaceStates {
  @override
  List<Object?> get props => [];
}

class CreateWorkSpaceLoadingState extends CreateWorkSpaceStates {
  @override
  List<Object?> get props => [];
}

class CreateWorkSpaceFailureState extends CreateWorkSpaceStates {
  final String error;

  CreateWorkSpaceFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class CreateWorkSpaceSuccessState extends CreateWorkSpaceStates {
  @override
  List<Object?> get props => [];
}
