import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/const/other_constant.dart';

List<String> employees = <String>[
  'Darpan Vithani',
  'Hardik Parmar',
  'Amisha Italiya',
  'Sumita kevat',
  'Jignesh Sanghani',
  'Radhika Saliya',
  'Nidhi Davra',
  'Dhvani Sukhadiya',
  'Rajvi Patel',
  'Nirlay Visaveliya',
  'Luzi Patel',
  'Shruti Sonani',
  'Jagruti Ahire',
  'Divesh vekariya',
  'Sneha Sanghani'
];

class SupervisorCard extends StatefulWidget {
  int? employeeId;

  SupervisorCard({Key? key, required this.employeeId}) : super(key: key);

  @override
  State<SupervisorCard> createState() => _SupervisorCardState();
}

class _SupervisorCardState extends State<SupervisorCard> {
  String? supervisorName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        child: ListTile(
          title: const Text(
            'Supervisor',
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: Colors.grey, fontSize: kLeaveRequestFontSize),
          ),
          trailing: DropdownButton(
            underline: Container(),
            isExpanded: false,
            focusColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            items: List<DropdownMenuItem<String>>.generate(employees.length,
                (index) {
              return DropdownMenuItem(
                  value: employees[index],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      employees[index],
                      style: GoogleFonts.ibmPlexSans(
                          color: Colors.black87,
                          fontSize: kLeaveRequestFontSize),
                    ),
                  ));
            }),
            style: const TextStyle(fontSize: 15, color: Colors.black87),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black87,
            ),
            onChanged: (String? value) {
              setState(() {
                supervisorName = value ?? '';
              });
            },
            value: supervisorName,
          ),
        ),
      ),
    );
  }
}
