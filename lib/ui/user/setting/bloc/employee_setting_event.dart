import 'package:equatable/equatable.dart';

abstract class EmployeeSettingEvent extends Equatable{}

class UpdateUserDetailsOnEmployeeSettingEvent extends EmployeeSettingEvent{
  @override
  List<Object?> get props => [];
}