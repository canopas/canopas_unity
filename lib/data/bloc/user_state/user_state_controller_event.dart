import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/space/space.dart';

abstract class UserStateControllerEvent {}

class CheckUserStatus extends UserStateControllerEvent {}

class ClearDataForDisableUser extends UserStateControllerEvent {}

class ShowUserStatusFetchError extends UserStateControllerEvent {}

class UpdateUserData extends UserStateControllerEvent {
  final Employee? employee;
  final Space? space;

  UpdateUserData({required this.employee, required this.space});
}
