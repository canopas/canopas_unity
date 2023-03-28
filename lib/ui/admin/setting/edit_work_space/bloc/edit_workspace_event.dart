import 'package:equatable/equatable.dart';

abstract class EditWorkSpaceEvent extends Equatable {}

class EditWorkSpaceInitialEvent extends EditWorkSpaceEvent {
  @override
  List<Object?> get props => [];
}

class YearlyPaidTimeOffChangeEvent extends EditWorkSpaceEvent {
  final String timeOff;

  YearlyPaidTimeOffChangeEvent({required this.timeOff});

  @override
  List<Object?> get props => [timeOff];
}

class CompanyNameChangeEvent extends EditWorkSpaceEvent {
  final String companyName;

  CompanyNameChangeEvent({required this.companyName});

  @override
  List<Object?> get props => [companyName];
}
