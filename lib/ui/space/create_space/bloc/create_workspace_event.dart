import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateSpaceEvent extends Equatable {}

class PageChangeEvent extends CreateSpaceEvent {
  final int page;

  PageChangeEvent({required this.page});

  @override
  List<Object?> get props => [page];
}

class CompanyNameChangeEvent extends CreateSpaceEvent {
  final String companyName;

  CompanyNameChangeEvent({required this.companyName});

  @override
  List<Object?> get props => [companyName];
}

class CompanyDomainChangeEvent extends CreateSpaceEvent {
  final String? domain;

  CompanyDomainChangeEvent({required this.domain});

  @override
  List<Object?> get props => [domain];
}

class CompanyLogoChangeEvent extends CreateSpaceEvent {
  @override
  List<Object?> get props => [];
}

class SubmitFormEvent extends CreateSpaceEvent {
  @override
  List<Object?> get props => [];
}

class PaidTimeOffChangeEvent extends CreateSpaceEvent {
  final String? paidTimeOff;

  PaidTimeOffChangeEvent({required this.paidTimeOff});

  @override
  List<Object?> get props => [paidTimeOff];
}

class CreateSpaceButtonTapEvent extends CreateSpaceEvent {
  @override
  List<Object?> get props => [];
}

class UserNameChangeEvent extends CreateSpaceEvent {
  final String? name;

  UserNameChangeEvent({this.name});

  @override
  List<Object?> get props => [name];
}

class PickImageEvent extends CreateSpaceEvent {
  final ImageSource imageSource;

  PickImageEvent({required this.imageSource});

  @override
  List<Object?> get props => [imageSource];
}
