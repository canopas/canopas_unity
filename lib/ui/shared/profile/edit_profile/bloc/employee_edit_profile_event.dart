import 'package:equatable/equatable.dart';

import '../../../../../data/model/employee/employee.dart';

abstract class EditProfileEvent extends Equatable {}

class EditProfileInitialLoadEvent extends EditProfileEvent {
  final Gender? gender;
  final DateTime? dateOfBirth;

  EditProfileInitialLoadEvent(
      {required this.gender, required this.dateOfBirth});

  @override
  List<Object?> get props => [gender, dateOfBirth];
}

class EditProfileNameChangedEvent extends EditProfileEvent {
  final String name;

  EditProfileNameChangedEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class EditProfileNumberChangedEvent extends EditProfileEvent {
  final String number;

  EditProfileNumberChangedEvent({required this.number});

  @override
  List<Object?> get props => [number];
}

class EditProfileChangeDateOfBirthEvent extends EditProfileEvent {
  final DateTime? dateOfBirth;

  EditProfileChangeDateOfBirthEvent({required this.dateOfBirth});

  @override
  List<Object?> get props => [dateOfBirth];
}

class EditProfileChangeGenderEvent extends EditProfileEvent {
  final Gender? gender;

  EditProfileChangeGenderEvent({
    required this.gender,
  });

  @override
  List<Object?> get props => [gender];
}

class ChangeImageEvent extends EditProfileEvent {
  final String imagePath;

  ChangeImageEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class EditProfileUpdateProfileEvent extends EditProfileEvent {
  final String name;
  final String designation;
  final String level;
  final String phoneNumber;
  final String address;

  EditProfileUpdateProfileEvent(
      {required this.name,
      required this.designation,
      required this.phoneNumber,
      required this.address,
      required this.level});

  @override
  List<Object?> get props => [name, designation, level, phoneNumber, address];
}
