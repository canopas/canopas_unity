import 'package:equatable/equatable.dart';

abstract class AdminHomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminHomeInitialLoadEvent extends AdminHomeEvent {}
