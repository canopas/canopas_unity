import 'package:flutter/material.dart';
import 'package:projectunity/model/employee.dart';

class EmployeeListWidget extends StatelessWidget {
  const EmployeeListWidget({Key? key, required this.employeeList})
      : super(key: key);

  final List<Employee> employeeList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: employeeList.length,
      itemBuilder: (BuildContext context, int index) {
        Employee employee = employeeList[index];
        return SizedBox(
          height: 120,
          child: Card(
            elevation: 10,
            child: Row(
              children: [
                const Icon(
                  Icons.account_circle_rounded,
                  size: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name ?? '',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      employee.designation ?? '',
                      style: const TextStyle(
                          // fontSize: 20,fontWeight: FontWeight.w300
                          ),
                    ),
                    Text(
                      employee.email,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    employee.employeeId,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
