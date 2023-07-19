import 'package:equatable/equatable.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/space/space.dart';

abstract class UserStateControllerEvent extends Equatable{}

class CheckUserStatus extends UserStateControllerEvent {
  @override
  List<Object?> get props => [];
}

class ClearDataForDisableUser extends UserStateControllerEvent {
  @override

  List<Object?> get props => [];
}
class UpdateUserData extends UserStateControllerEvent {
  final Employee employee;
  final Space space;
  UpdateUserData({required this.employee, required this.space});

  @override
  List<Object?> get props => [employee,space];
}