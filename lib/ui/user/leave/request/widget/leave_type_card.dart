import 'package:flutter/material.dart';

import '../../../../../utils/const/other_constant.dart';

List<String> leaves = <String>[
  'Casual Leave',
  'Sick Leave',
  'Annual Leave',
  'Paternity Leave',
  'Maternity Leave',
  'Marriage Leave',
  'Bereavement Leave',
];

class LeaveTypeCard extends StatefulWidget {
  String? leaveType;

  LeaveTypeCard({Key? key, required this.leaveType}) : super(key: key);

  @override
  State<LeaveTypeCard> createState() => _LeaveTypeCardState();
}

class _LeaveTypeCardState extends State<LeaveTypeCard> {
  @override
  void initState() {
    leaveType = widget.leaveType;
    super.initState();
  }

  String? leaveType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        child: ListTile(
          title: const Text(
            'Leave Type',
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: Colors.grey, fontSize: kLeaveRequestFontSize),
          ),
          trailing: DropdownButton(
            underline: Container(),
            isExpanded: false,
            focusColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            items: leaves.map((String leave) {
              return DropdownMenuItem<String>(
                  value: leave,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(leave),
                  ));
            }).toList(),
            style: const TextStyle(
                fontSize: kLeaveRequestFontSize, color: Colors.black87),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black87,
            ),
            onChanged: (String? value) {
              setState(() {
                leaveType = value ?? '';
              });
            },
            value: leaveType,
          ),
        ),
      ),
    );
  }
}
