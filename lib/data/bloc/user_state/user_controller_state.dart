import 'package:equatable/equatable.dart';
import 'package:projectunity/data/provider/user_state.dart';

class UserControllerState extends Equatable {
  final UserState? userState;

  const UserControllerState({ this.userState});

  @override
  List<Object?> get props => [userState];
}
