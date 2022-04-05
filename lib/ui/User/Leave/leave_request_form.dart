import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/ui/User/Leave/leave_screen.dart';

enum Leave { fullDay, firstHalf, secondHalf }

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({Key? key}) : super(key: key);

  @override
  _LeaveRequestFormState createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  Leave? _selectedLeave = Leave.fullDay;
  DateTime _selectedDate = DateTime.now();
  String selectedName = '';
  int selectedEmployeeId = 0;
  TextEditingController _textEditingController = TextEditingController();
  String reasonForLeave = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Apply for Leaves: ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Day type: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Column(
                children: [
                  RadioListTile<Leave>(
                      activeColor: Colors.blueGrey,
                      title: const Text('Full-Day'),
                      value: Leave.fullDay,
                      groupValue: _selectedLeave,
                      onChanged: (Leave? value) {
                        setState(() {
                          _selectedLeave = value;
                        });
                      }),
                  RadioListTile<Leave>(
                      activeColor: Colors.blueGrey,
                      title: const Text('First-Half'),
                      value: Leave.firstHalf,
                      groupValue: _selectedLeave,
                      onChanged: (Leave? value) {
                        setState(() {
                          _selectedLeave = value;
                        });
                      }),
                  RadioListTile<Leave>(
                      activeColor: Colors.blueGrey,
                      title: const Text('Second-Half'),
                      value: Leave.secondHalf,
                      groupValue: _selectedLeave,
                      onChanged: (Leave? value) {
                        setState(() {
                          _selectedLeave = value;
                        });
                      })
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'From: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Card(
                        child: Row(
                      children: [
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          '${_selectedDate.toLocal()}'.split(' ')[0],
                          style: const TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          icon: const Icon(Icons.apps_outlined),
                          onPressed: () async {
                            DateTime? startDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                textDirection: TextDirection.ltr,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030));
                            if (startDate != null &&
                                startDate != _selectedDate) {
                              setState(() {
                                _selectedDate = startDate;
                              });
                            }
                          },
                        )
                      ],
                    ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'To: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Card(
                        child: Row(
                      children: [
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          '${_selectedDate.toLocal()}'.split(' ')[0],
                          style: const TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          icon: const Icon(Icons.apps_outlined),
                          onPressed: () async {
                            DateTime? endDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                textDirection: TextDirection.ltr,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030));
                            if (endDate != null && endDate != _selectedDate) {
                              setState(() {
                                _selectedDate = endDate;
                              });
                            }
                          },
                        )
                      ],
                    ))
                  ],
                ),
              ],
            ),
            Card(
                child: ListTile(
                    title: const Text(
                      'You can Contact: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      selectedName,
                      style: const TextStyle(fontSize: 20),
                    ),
                    trailing: PopupMenuButton(
                        icon: const Icon(Icons.add),
                        onSelected: (index) {
                          setState(() {
                            selectedEmployeeId = index as int;
                            selectedName =
                                employeeList.elementAt(selectedEmployeeId);
                          });
                        },
                        itemBuilder: (BuildContext context) => List.generate(
                              4,
                              (index) => PopupMenuItem(
                                  child: Text(employeeList.elementAt(index)),
                                  value: employeeID.elementAt(index)),
                            )))),
            const Text(
              "Reason",
              style: TextStyle(fontSize: 20),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Enter reason',
                      ),
                      autofocus: true,
                      controller: _textEditingController,
                      keyboardType: TextInputType.multiline,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () {
                            reasonForLeave = _textEditingController.text;
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueGrey),
                          ),
                          child: const Text(
                            'OK',
                            style: TextStyle(fontSize: 20),
                          )),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.blueGrey),
                    ),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(fontSize: 20),
                    )),
                ElevatedButton(
                    onPressed: () {
                      reasonForLeave = _textEditingController.text;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LeaveScreen()));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                    ),
                    child: const Text(
                      'APPLY',
                      style: TextStyle(fontSize: 20),
                    )),

              ],
            ),
          ],
        ),
      )),
    );
  }

  List<String> employeeList = ['Sneha', 'Radhi', 'Jimmy', 'Ami'];
  List<int> employeeID = [0, 1, 2, 3];
}
