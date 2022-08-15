import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../model/employee/employee.dart';
import 'employee_card.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({
    Key? key,
    required this.employees,
  }) : super(key: key);

  final List<Employee> employees;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 40),
        itemCount: employees.length,
        itemBuilder: (BuildContext context, int index) {
          Employee employee = employees[index];
          return EmployeeCard(employee: employee);
        },
      ),
    );
  }
}
