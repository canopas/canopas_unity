import 'package:equatable/equatable.dart';

import '../../../../../data/model/employee/employee.dart';

abstract class ViewProfileState extends Equatable {}

class ViewProfileInitialState extends ViewProfileState {
  @override
  List<Object?> get props => [];
}

class ViewProfileLoadingState extends ViewProfileState {
  @override
  List<Object?> get props => [];
}

class ViewProfileSuccessState extends ViewProfileState {
  final Employee employee;

  ViewProfileSuccessState(this.employee);

  @override
  List<Object?> get props => [employee];
}

class ViewProfileErrorState extends ViewProfileState {
  final String error;

  ViewProfileErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
