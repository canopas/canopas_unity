import 'package:equatable/equatable.dart';

abstract class EditWorkspaceStates extends Equatable {}

class EditWorkspaceInitialState extends EditWorkspaceStates {
  @override
  List<Object?> get props => [];
}

class EditWorkspaceLoadingState extends EditWorkspaceStates {
  @override
  List<Object?> get props => [];
}

class EditWorkspaceFailureState extends EditWorkspaceStates {
  final String error;

  EditWorkspaceFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class EditWorkspaceSuccessState extends EditWorkspaceStates {
  @override
  List<Object?> get props => [];
}
