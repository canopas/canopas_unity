import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../model/employee/employee.dart';

class ProfileDetail extends StatelessWidget {
  final Employee employee;

  const ProfileDetail({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Details(
          title: 'Role: ',
          subTitle: employee.getRole(),
        ),
        Details(
          title: 'Mobile: ',
          subTitle: employee.phone,
        ),
        Details(title: 'Email: ', subTitle: employee.email),
        Details(title: 'Address: ', subTitle: employee.address),
        Details(
          title: 'Date of Birth: ',
          subTitle: employee.dateOfBirth.toString(),
        ),
        Details(
          title: 'Date of Joining: ',
          subTitle: employee.dateOfJoining.toString(),
        ),
        Details(title: 'Employee ID: ', subTitle: employee.employeeId)
      ],
    );
  }
}

class DetailDivider extends StatelessWidget {
  const DetailDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 25,
      endIndent: 25,
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    GoogleFonts.ibmPlexSans(fontSize: 20, color: Colors.grey),
              ),
              Text(
                subTitle ?? '-',
                style:
                    GoogleFonts.ibmPlexSans(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }
}
