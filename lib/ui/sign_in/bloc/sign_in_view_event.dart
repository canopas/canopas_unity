import 'package:equatable/equatable.dart';

abstract class SignInEvent{}

class GoogleSignInEvent extends SignInEvent {}
class AppleSignInEvent extends SignInEvent {}

