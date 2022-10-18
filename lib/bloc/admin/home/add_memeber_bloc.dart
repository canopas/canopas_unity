import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/const/role.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../navigation/navigation_stack_manager.dart';
import '../../../rest/api_response.dart';
import '../../../services/admin/employee/employee_service.dart';

@Injectable()
class AddMemberBloc extends BaseBLoc {
  final EmployeeService _employeeService;
  final NavigationStackManager _stackManager;

  AddMemberBloc(this._employeeService, this._stackManager);

  final BehaviorSubject<String> _email = BehaviorSubject<String>();
  Stream<String> get email => _email.stream;

  final BehaviorSubject<String> _employeeId = BehaviorSubject<String>();
  Stream<String> get employeeId => _employeeId.stream;

  final BehaviorSubject<String> _name = BehaviorSubject<String>();
  Stream<String> get name => _name.stream;

  final BehaviorSubject<String> _designation = BehaviorSubject<String>();
  Stream<String> get designation => _designation.stream;

  final BehaviorSubject<DateTime> _dateOfJoining = BehaviorSubject<DateTime>.seeded(DateTime.now());
  Stream<DateTime> get dateOfJoining => _dateOfJoining.stream;

  final _addEmployeeStream = BehaviorSubject<ApiResponse<bool>>();
  Stream<ApiResponse<bool>> get addEmployeeStream => _addEmployeeStream.stream;

  int roleType = kRoleTypeEmployee;

  void validateEmail(String email, BuildContext context) {
    if (email.isNotEmpty && email.length > 4) {
      if (email.contains('@')) {
        _email.sink.add(email);
      }
    } else {
      _email.sink
          .addError(AppLocalizations.of(context).admin_add_member_error_email);
    }
  }

  void validateName(String name, BuildContext context) {
    if (name.isEmpty) {
      _name.sink.addError(
          AppLocalizations.of(context).admin_add_member_error_complete_field);
    } else if (name.length >= 4) {
      _name.sink.add(name);
    } else {
      _name.sink
          .addError(AppLocalizations.of(context).admin_add_member_error_name);
    }
  }

  void validateDesignation(String designation, BuildContext context) {
    if (designation.length > 4) {
      _designation.sink.add(designation);
    } else {
      _designation.sink.addError(
          AppLocalizations.of(context).admin_add_member_error_complete_field);
    }
  }

  void validateEmployeeId(String employeeId, BuildContext context) {
    if (employeeId.length >= 4) {
      if (employeeId.contains(RegExp(r'[a-zA-Z0-9]'))) {
        _employeeId.sink.add(employeeId);
      }
    } else {
      _employeeId.sink.addError(
          AppLocalizations.of(context).admin_add_member_error_complete_field);
    }
  }

  void validateDateOfJoining(DateTime joiningDate) {
    _dateOfJoining.sink.add(joiningDate);
  }

  Stream<bool> get validateSubmit => Rx.combineLatest5(employeeId, name, email,
      designation, dateOfJoining, (a, b, c, d, e) => true);

  Employee submit(int selectedRoleType) {
    final employee = Employee(
        id: const Uuid().v4(),
        roleType: selectedRoleType,
        name: _name.stream.value,
        employeeId: _employeeId.value,
        email: _email.value,
        designation: _designation.value,
        dateOfJoining: _dateOfJoining.value.timeStampToInt);
    return employee;
  }

  Future<void> addEmployee() async {
    _addEmployeeStream.sink.add(const ApiResponse.loading());

    Employee employee = submit(roleType);

    bool userExists = await _employeeService.hasUser(employee.email);
    if (userExists) {
      _addEmployeeStream.sink
          .add(const ApiResponse.error(error: userAlreadyExists));
      return;
    }

    await _employeeService.addEmployee(employee);
    _stackManager.pop();
    _addEmployeeStream.sink.add(const ApiResponse.completed(data: true));
  }

  void setSelectedRole(int role) {
    roleType = role;
  }

  @override
  void attach() {}

  @override
  void detach() {
    _email.close();
    _name.close();
    _designation.close();
    _employeeId.close();
    _dateOfJoining.close();
    _addEmployeeStream.close();
  }
}
