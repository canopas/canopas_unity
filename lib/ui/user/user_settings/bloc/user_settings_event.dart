import 'package:equatable/equatable.dart';

abstract class UserSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCurrentEmployeeUserSettingsEvent extends UserSettingsEvent {}

class UserSettingsLogOutEvent extends UserSettingsEvent {}
