import 'package:equatable/equatable.dart';

abstract class AdminSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCurrentEmployeeAdminSettingsEvent extends AdminSettingsEvent {}

class AdminSettingsLogOutEvent extends AdminSettingsEvent {}
