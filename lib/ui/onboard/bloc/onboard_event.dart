import 'package:equatable/equatable.dart';

abstract class OnBoardEvent extends Equatable {

}

class SetOnBoardCompletedEvent extends OnBoardEvent {
  @override
  List<Object?> get props => [];

}

class CurrentPageChangeEvent extends OnBoardEvent {
  final int page;
  CurrentPageChangeEvent({required this.page});
  @override
  List<Object?> get props => [page];

}