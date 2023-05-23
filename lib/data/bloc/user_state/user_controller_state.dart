import 'package:equatable/equatable.dart';
import 'package:projectunity/data/provider/user_state.dart';

enum StateController { initial, enable, disable }

class UserControllerState extends Equatable {
  final UserState userState;

  const UserControllerState({required this.userState});

  @override
  List<Object?> get props => [userState];
}
