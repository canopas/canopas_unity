import 'package:equatable/equatable.dart';

enum SubmitFormStatus { initial, loading, done, error }

class AddMemberFormState extends Equatable {
  final int? role;
  final String? employeeId;
  final String? name;
  final String? email;
  final String? designation;
  final DateTime? dateOfJoining;
  final bool idError;
  final bool emailError;
  final bool nameError;
  final bool designationError;
  final SubmitFormStatus? status;
  final String? msg;

  const AddMemberFormState(
      {this.role = 2,
      this.employeeId = '',
      this.name = '',
      this.email = '',
      this.designation = '',
      this.dateOfJoining,
      this.idError=false,
      this.designationError=false,
      this.emailError=false,
      this.nameError=false,
      this.msg,
      this.status = SubmitFormStatus.initial});

  AddMemberFormState copyWith(
      {int? role,
      String? employeeId,
      String? name,
      String? email,
      String? designation,
      DateTime? dateOfJoining,
      String? msg,
      bool? idError,
      bool? designationError,
      bool? emailError,
      bool? nameError,
      SubmitFormStatus? status}) {
    return AddMemberFormState(
        role: role ?? this.role,
        employeeId: employeeId ?? this.employeeId,
        name: name ?? this.name,
        email: email ?? this.email,
        designation: designation ?? this.designation,
        dateOfJoining: dateOfJoining ?? this.dateOfJoining,
        idError: idError??this.idError,
        designationError: designationError??this.designationError,
        emailError: emailError??this.emailError,
        nameError: nameError??this.nameError,
        msg: msg,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        employeeId,
        email,
        name,
        role,
        dateOfJoining,
        designation,
        idError,
        nameError,
        emailError,
        designationError,
        status,
        msg
      ];
}
