import 'package:equatable/equatable.dart';

abstract class AdminLeavesEvent extends Equatable {}

class AdminLeavesInitialLoadEvent extends AdminLeavesEvent {
  @override
  List<Object?> get props => [];
}

class AdminFetchMoreRecentLeavesEvent extends AdminLeavesEvent {
  @override
  List<Object?> get props => [];
}
