import 'package:equatable/equatable.dart';
import 'package:projectunity/data/provider/user_state.dart';

abstract class UserControllerState extends Equatable {

  @override
  List<Object?> get props => [];
}
class UserControllerErrorState extends UserControllerState{
  final String error;
  UserControllerErrorState({required this.error});
}
class UserControllerInitialState extends UserControllerState{

}

class RevokeAccessState extends UserControllerState{}
