import 'package:equatable/equatable.dart';

abstract class UserHomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class UserHomeFetchEvent extends UserHomeEvent {}
class ChangeToBeforeDateEvent extends UserHomeEvent {}
class ChangeToAfterDateEvent extends UserHomeEvent {}
