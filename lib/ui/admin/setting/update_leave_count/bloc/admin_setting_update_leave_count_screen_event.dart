import 'package:equatable/equatable.dart';

abstract class AdminSettingUpdatePaidLeaveCountEvent extends Equatable {

}

class AdminSettingPaidLeaveCountInitialLoadEvent extends AdminSettingUpdatePaidLeaveCountEvent {
  @override
  List<Object?> get props => [];

}

class UpdatePaidLeaveCountEvent extends AdminSettingUpdatePaidLeaveCountEvent {
  final String leaveCount;
  UpdatePaidLeaveCountEvent({required this.leaveCount});
  @override
  List<Object?> get props => [leaveCount];
}


