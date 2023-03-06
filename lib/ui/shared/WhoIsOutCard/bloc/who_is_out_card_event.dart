import 'package:equatable/equatable.dart';

abstract class WhoIsOutEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class WhoIsOutInitialLoadEvent extends WhoIsOutEvent {}
class ChangeToBeforeDateEvent extends WhoIsOutEvent {}
class ChangeToAfterDateEvent extends WhoIsOutEvent {}
