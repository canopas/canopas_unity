import 'package:equatable/equatable.dart';

abstract class SignInEvents extends Equatable {}

class SignInEvent extends SignInEvents {
  @override
  List<Object?> get props => [];
}

class CreateSpaceSignInEvent extends SignInEvents {
  @override
  List<Object?> get props => [];
}
