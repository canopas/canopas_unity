import 'package:flutter/material.dart';
import 'package:projectunity/model/Employee/employee.dart';

class EmployeeWidget extends StatelessWidget {
  const EmployeeWidget({Key? key, required this.employee, required this.ontap})
      : super(key: key);

  final Employee employee;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 10,
        child: InkWell(
          hoverColor: Colors.blueGrey,
          onTap: ontap,
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
                        fontSize: 20, fontWeight: FontWeight.w300),
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
      ),
    );
  }
}
