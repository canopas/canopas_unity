import 'package:equatable/equatable.dart';

import '../../model/employee/employee.dart';

abstract class SpaceUserEvent extends Equatable {}

class CheckSpaceEvent extends SpaceUserEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckUserEvent extends SpaceUserEvent {
  final Employee? employee;

  CheckUserEvent({required this.employee});

  @override
  // TODO: implement props
  List<Object?> get props => [employee];
}

class DeactivateUserEvent extends SpaceUserEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
