import 'package:equatable/equatable.dart';

abstract class WhoIsOutViewEvent extends Equatable{}


class WhoIsOutViewInitialLoadEvent extends WhoIsOutViewEvent {
  @override
  List<Object?> get props => [];

}

class GetSelectedDateLeavesEvent extends WhoIsOutViewEvent {
  final DateTime selectedDate;
  GetSelectedDateLeavesEvent(this.selectedDate);
  @override
  List<Object?> get props => [selectedDate];
}
