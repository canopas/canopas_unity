import 'package:equatable/equatable.dart';

abstract class AdminSettingUpdateLeaveCountState extends Equatable {

}

class AdminSettingUpdateLeaveCountInitialState extends AdminSettingUpdateLeaveCountState {
  @override
  List<Object?> get props => [];

}

class AdminSettingUpdateLeaveCountLoadingState extends AdminSettingUpdateLeaveCountState {

  @override
  List<Object?> get props => [];

}

class AdminSettingUpdateLeaveCountSuccessState extends AdminSettingUpdateLeaveCountState {
  final int paidLeaveCount;
  AdminSettingUpdateLeaveCountSuccessState({required this.paidLeaveCount});

  @override
  List<Object?> get props => [paidLeaveCount];
}

class AdminSettingUpdateLeaveCountFailureState extends AdminSettingUpdateLeaveCountState {
  final String error;
  AdminSettingUpdateLeaveCountFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}