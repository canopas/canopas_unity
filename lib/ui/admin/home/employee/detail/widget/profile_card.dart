import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/widget/user_profile_image.dart';

import '../../../../../../configs/colors.dart';
import '../../../../../../model/employee/employee.dart';

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
                      style: const TextStyle(
                          fontSize: subTitleTextSize, color: Colors.grey),
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
            child: ImageProfile(
              iconSize: 120,
              imageUrl: employee.imageUrl,
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
      style: const TextStyle(fontSize: titleTextSize, color: Colors.black54),
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
      style: const TextStyle(
          fontSize: largeTitleTextSize,
          color: Colors.black,
          fontWeight: FontWeight.w500),
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
                const Text(
                  'Designation',
                  style: TextStyle(fontSize: bodyTextSize, color: Colors.grey),
                ),
                Text(designation,
                    style: const TextStyle(
                        fontSize: titleTextSize,
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
              const Text(
                'Role',
                style: TextStyle(fontSize: bodyTextSize, color: Colors.grey),
              ),
              Text(
                role,
                style: const TextStyle(
                    fontSize: titleTextSize,
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
            color: AppColors.peachColor.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: IconButton(onPressed: () {}, icon: icon, color: Colors.white),
    );
  }
}
