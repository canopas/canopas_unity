import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';

import '../../../../../configs/colors.dart';

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
  const SupervisorCard({Key? key}) : super(key: key);

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
            style: TextStyle(
                color: AppColors.secondaryText, fontSize: subTitleTextSize),
          ),
          trailing: DropdownButton(
            underline: Container(),
            isExpanded: false,
            focusColor: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
            items: List<DropdownMenuItem<String>>.generate(employees.length,
                (index) {
              return DropdownMenuItem(
                  value: employees[index],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      employees[index],
                      style: const TextStyle(
                          color: AppColors.darkText,
                          fontSize: subTitleTextSize),
                    ),
                  ));
            }),
            style: const TextStyle(
                fontSize: bodyTextSize, color: AppColors.darkText),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.darkText,
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
