import 'package:equatable/equatable.dart';
import '../../../../data/model/space/space.dart';

abstract class ChangeSpaceEvents extends Equatable {}

class ChangeSpaceInitialLoadEvent extends ChangeSpaceEvents {
  @override
  List<Object?> get props => [];
}

class SelectSpaceEvent extends ChangeSpaceEvents {
  final Space space;
  SelectSpaceEvent(this.space);
  @override
  List<Object?> get props => [space];
}
