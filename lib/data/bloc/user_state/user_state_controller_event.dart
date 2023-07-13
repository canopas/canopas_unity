abstract class UserStateControllerEvent {}

class CheckUserStatus extends UserStateControllerEvent {}

class ClearDataForDisableUser extends UserStateControllerEvent {}

class UpdateUserDataEvent extends UserStateControllerEvent {}

class DeactivateUserEvent extends UserStateControllerEvent {}

