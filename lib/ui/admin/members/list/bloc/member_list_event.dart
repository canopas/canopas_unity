import 'package:equatable/equatable.dart';

abstract class AdminMembersEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminMembersInitialLoadEvent extends AdminMembersEvents {}
