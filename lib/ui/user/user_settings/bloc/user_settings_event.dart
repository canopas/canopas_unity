import 'package:equatable/equatable.dart';

abstract class UserSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCurrentEmployeeEvent extends UserSettingsEvent {}

class UserSettingsLogOutEvent extends UserSettingsEvent {}
