import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/navigation/navigation_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';

import '../../../../../di/service_locator.dart';
import '../../../../../model/employee/employee.dart';

class EmployeeCard extends StatelessWidget {
  EmployeeCard({Key? key, required this.employee}) : super(key: key);

  final NavigationStackManager _stackManager = getIt<NavigationStackManager>();
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: InkWell(
        onTap: () {
          _stackManager
              .push(NavigationStackItem.employeeDetailState(id: employee.id));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              EmployeeImage(
                imageUrl: employee.imageUrl,
                radius: height / 100 * 2,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EmployeeName(name: employee.name),
                  const SizedBox(
                    height: 7,
                  ),
                  EmployeeDesignation(designation: employee.designation)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeImage extends StatelessWidget {
  const EmployeeImage({Key? key, required this.imageUrl, required this.radius})
      : super(key: key);
  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Container(
          width: 70,
          height: 70,
          child: Icon(
            Icons.account_circle_rounded,
            size: 70,
            color: Colors.grey[900],
          ));
    } else {
      return Container(
        width: 70,
        height: 70,
        child: CircleAvatar(
          radius: 70,
          backgroundImage: NetworkImage(imageUrl!),
        ),
      );
    }
  }
}

class EmployeeName extends StatelessWidget {
  const EmployeeName({Key? key, required this.name}) : super(key: key);
  final String? name;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Text(
      name ?? '',
      textAlign: TextAlign.start,
      style: height >= 700
          ? GoogleFonts.ibmPlexSans(fontSize: 20, fontWeight: FontWeight.w500)
          : GoogleFonts.ibmPlexSans(fontSize: 17, fontWeight: FontWeight.w500),
    );
  }
}

class EmployeeDesignation extends StatelessWidget {
  const EmployeeDesignation({Key? key, required this.designation})
      : super(key: key);
  final String? designation;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Text(
      designation ?? '',
      textAlign: TextAlign.start,
      style: height >= 700
          ? GoogleFonts.ibmPlexSans(fontSize: 18, color: Colors.black54)
          : GoogleFonts.ibmPlexSans(fontSize: 15, color: Colors.black54),
    );
  }
}
