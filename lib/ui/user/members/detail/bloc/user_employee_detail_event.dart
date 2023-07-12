import 'package:equatable/equatable.dart';

abstract class UserEmployeeDetailEvent extends Equatable {}

class UserEmployeeDetailFetchEvent extends UserEmployeeDetailEvent {
  final String uid;

  UserEmployeeDetailFetchEvent({required this.uid});

  @override
  List<Object?> get props => [uid];
}
