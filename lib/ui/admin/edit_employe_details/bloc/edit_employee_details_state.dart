import 'package:equatable/equatable.dart';

enum AdminEditEmployeeDetailsStatus{initial,loading,success,failure}
class AdminEditEmployeeDetailsState extends Equatable {
  final AdminEditEmployeeDetailsStatus adminEditEmployeeDetailsStatus;
  final String name;
  final String? id;
  final int roleType;
  final String email;
  final String designation;
  final DateTime? dateOfJoining;
  final String level;
  final String employeeId;
  final String phoneNumber;
  final String? error;

  const AdminEditEmployeeDetailsState({
    this.error,
    this.id,
    this.adminEditEmployeeDetailsStatus = AdminEditEmployeeDetailsStatus.initial,
    this.name = "",
    this.roleType = 2,
    this.email = "",
    this.designation = "",
    this.employeeId = "",
    this.phoneNumber = "",
    this.level = "",
    this.dateOfJoining,
});

  copyWith({
      String? id,
      String? name,
      String? error,
      String? designation,
      String? employeeId,
      String? phoneNumber,
      String? level,
      String? email,
      DateTime? dateOfJoining,
      int? roleType,
      AdminEditEmployeeDetailsStatus? adminEditEmployeeDetailsStatus,}){
    return AdminEditEmployeeDetailsState(
      error: error,
      name: name ?? this.name,
      level: level ?? this.level,
      roleType: roleType ?? this.roleType,
      email: email?? this.email,
      designation: designation??this.designation,
      employeeId: employeeId ?? this.employeeId,
      adminEditEmployeeDetailsStatus: adminEditEmployeeDetailsStatus ?? this.adminEditEmployeeDetailsStatus,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      id: id ?? this.id,
    );
  }



  @override
  List<Object?> get props => throw [id,name,designation,email,phoneNumber,designation,level,dateOfJoining,error];

}

