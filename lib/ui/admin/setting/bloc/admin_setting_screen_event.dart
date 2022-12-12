import 'package:equatable/equatable.dart';

abstract class AdminSettingScreenEvent extends Equatable {
}

class NavigateToPaidLeaveCountEvent extends AdminSettingScreenEvent{
  @override
  List<Object?> get props => [];
}