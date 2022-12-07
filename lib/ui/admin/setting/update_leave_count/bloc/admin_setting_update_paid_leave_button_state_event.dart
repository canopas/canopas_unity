
import 'package:equatable/equatable.dart';

abstract class AdminPaidLeaveUpdateSettingTextFieldEvent extends Equatable{}
class PaidLeaveTextFieldChangeValueEvent extends AdminPaidLeaveUpdateSettingTextFieldEvent{
  final String value;
  PaidLeaveTextFieldChangeValueEvent({required this.value});
  @override
  List<Object?> get props => [value];
}