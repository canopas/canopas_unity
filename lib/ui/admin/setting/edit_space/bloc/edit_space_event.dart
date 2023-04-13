import 'package:equatable/equatable.dart';

abstract class EditSpaceEvent extends Equatable {}

class EditSpaceInitialEvent extends EditSpaceEvent {
  @override
  List<Object?> get props => [];
}

class YearlyPaidTimeOffChangeEvent extends EditSpaceEvent {
  final String timeOff;

  YearlyPaidTimeOffChangeEvent({required this.timeOff});

  @override
  List<Object?> get props => [timeOff];
}

class CompanyNameChangeEvent extends EditSpaceEvent {
  final String companyName;

  CompanyNameChangeEvent({required this.companyName});

  @override
  List<Object?> get props => [companyName];
}

class DeleteSpaceEvent extends EditSpaceEvent {

  @override
  List<Object?> get props => [];
}

class SaveSpaceDetails extends EditSpaceEvent {
  final String paidTimeOff;
  final String spaceName;
  final String spaceDomain;

  SaveSpaceDetails(
      {required this.paidTimeOff,
      required this.spaceName,
      required this.spaceDomain});

  @override
  List<Object?> get props => [
        paidTimeOff,
        spaceName,
        spaceDomain,
      ];
}
