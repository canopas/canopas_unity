import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Navigation /app_state_manager.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../model/Employee/employee.dart';

class EmployeeCard extends StatelessWidget {
  EmployeeCard({Key? key, required this.employee}) : super(key: key);

  final AppStateManager appStateManager = getIt<AppStateManager>();
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white54,
      child: InkWell(
        onTap: () {
          appStateManager.onTapOfEmployee(employee.id);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 40, bottom: 20),
          child: Row(
            children: [
              EmployeeImage(imageUrl: employee.imageUrl),
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
  const EmployeeImage({Key? key, required this.imageUrl}) : super(key: key);
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return imageUrl == null
        ? const Icon(
            Icons.account_circle_rounded,
            size: 70,
          )
        : CircleAvatar(
            radius: height / 100 * 3.5,
            backgroundImage: NetworkImage(imageUrl!));
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
