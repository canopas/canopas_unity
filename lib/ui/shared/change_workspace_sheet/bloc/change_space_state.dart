import 'package:equatable/equatable.dart';
import '../../../../data/model/space/space.dart';

abstract class ChangeSpaceStates extends Equatable {}

class ChangeSpaceInitialState extends ChangeSpaceStates {
  @override
  List<Object?> get props => [];
}

class ChangeSpaceLoadingState extends ChangeSpaceStates {
  @override
  List<Object?> get props => [];
}

class ChangeSpaceSuccessState extends ChangeSpaceStates {
  final List<Space> spaces;

  ChangeSpaceSuccessState(this.spaces);

  @override
  List<Object?> get props => [spaces];
}

class ChangeSpaceFailureState extends ChangeSpaceStates {
  final String error;

  ChangeSpaceFailureState(this.error);

  @override
  List<Object?> get props => [error];
}