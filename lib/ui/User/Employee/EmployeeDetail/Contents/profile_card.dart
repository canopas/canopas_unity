import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/ui/User/Employee/employeeList/Contents/employee_card.dart';

import '../../../../../model/Employee/employee.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.employee}) : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 60 * 2 - 50,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 25),
                child: Column(
                  children: [
                    EmployeeName(name: employee.name),
                    EmployeeLevel(level: employee.level),
                    DesignationAndRoleCard(
                      designation: employee.designation,
                      role: employee.status,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ContactIcon(
                          color: Colors.deepOrange,
                          icon: FaIcon(FontAwesomeIcons.phone),
                        ),
                        ContactIcon(
                          color: Colors.green,
                          icon: FaIcon(FontAwesomeIcons.whatsapp),
                        ),
                        ContactIcon(
                          color: Colors.blue,
                          icon: FaIcon(FontAwesomeIcons.envelope),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: EmployeeImage(
              imageUrl: employee.imageUrl,
              radius: 60,
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeeLevel extends StatelessWidget {
  const EmployeeLevel({
    Key? key,
    required this.level,
  }) : super(key: key);

  final String? level;

  @override
  Widget build(BuildContext context) {
    return Text(
      level ?? '',
      style: GoogleFonts.ibmPlexSans(fontSize: 20, color: Colors.black54),
    );
  }
}

class EmployeeName extends StatelessWidget {
  const EmployeeName({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name ?? '-',
      style: GoogleFonts.ibmPlexSans(
          fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }
}

class DesignationAndRoleCard extends StatelessWidget {
  final String? designation;
  final int? role;

  const DesignationAndRoleCard(
      {Key? key, required this.designation, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              children: [
                Text(
                  'Designation',
                  style:
                      GoogleFonts.ibmPlexSans(fontSize: 15, color: Colors.grey),
                ),
                Text(designation ?? '-',
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
          const VerticalDivider(
            color: Colors.grey,
            indent: 25,
            endIndent: 25,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
            child: Column(children: [
              Text(
                'Role',
                style:
                    GoogleFonts.ibmPlexSans(fontSize: 15, color: Colors.grey),
              ),
              _createRole(role!)
            ]),
          )
        ],
      ),
    );
  }

  Text _createRole(int role) {
    String name = '';
    switch (role) {
      case 1:
        name = 'Admin';
        break;
      case 2:
        name = 'HR';
        break;
      case 3:
        name = 'Standard';
    }
    return Text(
      name,
      style: GoogleFonts.ibmPlexSans(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }
}

class ContactIcon extends StatelessWidget {
  final Color color;
  final FaIcon icon;

  const ContactIcon({Key? key, required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: IconButton(onPressed: () {}, icon: icon, color: Colors.white),
    );
  }
}
