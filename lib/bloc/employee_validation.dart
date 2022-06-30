import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class EmployeeValidationBloc {
  final BehaviorSubject<String> _email = BehaviorSubject<String>();

  Stream<String> get email => _email.stream;

  final BehaviorSubject<String> _employeeId = BehaviorSubject<String>();

  Stream<String> get employeeId => _employeeId.stream;

  final BehaviorSubject<String> _name = BehaviorSubject<String>();

  Stream<String> get name => _name.stream;

  final BehaviorSubject<String> _designation = BehaviorSubject<String>();

  Stream<String> get designation => _designation.stream;

  void validateEmail(String email) {
    if (email.isNotEmpty && email.length > 4) {
      if (email.contains('@')) {
        _email.sink.add(email);
      }
    } else {
      _email.sink.addError('Please enter valid email');
    }
  }

  void validateName(String name) {
    if (name.isNotEmpty && name.length >= 4) {
      _name.sink.add(name);
    } else {
      _name.sink.addError('Please enter at least 4 character of your name ');
    }
  }

  void validateDesignation(String designation) {
    if (designation.length > 4) {
      _designation.sink.add(designation);
    } else {
      _designation.sink.addError('Please complete this mandatory field');
    }
  }

  void validateEmployeeId(String employeeId) {
    if (employeeId.length > 4) {
      if (employeeId.contains(RegExp(r'[0-9]'))) {
        _employeeId.sink.add(employeeId);
      }
    } else {
      _employeeId.sink.addError('Please complete this mandatory field');
    }
  }

  Stream<bool> get validateSubmit => Rx.combineLatest4(
      employeeId, name, email, designation, (a, b, c, d) => true);

  Employee submit(int selectedRoleType) {
    final employee = Employee(
        id: FirebaseAuth.instance.currentUser!.uid,
        roleType: selectedRoleType,
        name: _name.stream.value,
        employeeId: _employeeId.value,
        email: _email.value,
        designation: _designation.value);
    return employee;
  }

  dispose() {
    _email.close();
    _name.close();
    _designation.close();
    _employeeId.close();
  }
}
