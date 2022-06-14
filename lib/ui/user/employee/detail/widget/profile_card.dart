import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/utils/const/color_constant.dart';

import '../../../../../model/employee/employee.dart';

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
            top: 60,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 25),
                child: Column(
                  children: [
                    EmployeeName(name: employee.name),
                    const SizedBox(height: 6),
                    Text(
                      employee.designation,
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ContactIcon(
                          color: Colors.deepOrange,
                          icon: FaIcon(FontAwesomeIcons.phone),
                        ),
                        SizedBox(width: 20),
                        ContactIcon(
                          color: Colors.green,
                          icon: FaIcon(FontAwesomeIcons.whatsapp),
                        ),
                        SizedBox(width: 20),
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

class EmployeeImage extends StatelessWidget {
  const EmployeeImage({Key? key, required this.imageUrl, required this.radius})
      : super(key: key);
  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? const Icon(
            Icons.account_circle_rounded,
            size: 120,
          )
        : Container(
            child: PhysicalShape(
              color: Colors.transparent,
              shadowColor: Colors.black,
              elevation: 24,
              clipper: const ShapeBorderClipper(shape: CircleBorder()),
              child: CircleAvatar(
                  radius: radius, backgroundImage: NetworkImage(imageUrl!)),
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
  final String designation;
  final String role;

  const DesignationAndRoleCard(
      {Key? key, required this.designation, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Text(
                  'Designation',
                  style:
                      GoogleFonts.ibmPlexSans(fontSize: 15, color: Colors.grey),
                ),
                Text(designation,
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
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(children: [
              Text(
                'Role',
                style:
                    GoogleFonts.ibmPlexSans(fontSize: 15, color: Colors.grey),
              ),
              Text(
                role,
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )
            ]),
          )
        ],
      ),
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
      height: 60,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(kPrimaryColour).withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: IconButton(onPressed: () {}, icon: icon, color: Colors.white),
    );
  }
}
