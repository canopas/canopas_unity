import 'package:equatable/equatable.dart';

abstract class EditWorkSpaceEvent extends Equatable {}

class EditWorkSpaceInitialEvent extends EditWorkSpaceEvent {
  @override
  List<Object?> get props => [];
}
