import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave_request_data.dart';
import 'package:projectunity/services/LeaveService/apply_for_leaves_api_service.dart';
import 'package:projectunity/ui/User/Leave/LeaveDetail/employee_all_leaves.dart';

enum Leave { fullDay, firstHalf, secondHalf }

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({Key? key}) : super(key: key);

  @override
  _LeaveRequestFormState createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  Leave? _selectedLeave = Leave.fullDay;
  final DateTime _selectedDate = DateTime.now();
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();
  int startDateToInt = 0;
  int endDateToInt = 0;
  String selectedName = '';
  int selectedEmployeeId = 0;
  late TextEditingController _textEditingController;
  String reasonForLeave = '';
  final ApplyForLeaveApiService _apiService = getIt<ApplyForLeaveApiService>();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
          body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Apply for Leaves: ',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                            '${startDate?.toLocal()}'.split(' ')[0],
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(Icons.apps_outlined),
                            onPressed: () async {
                              startDate = await getDate(_selectedDate);
                              String formattedString = startDate.toString();
                              DateTime date = DateTime.parse(formattedString);
                              String dateString = date.day.toString() +
                                  date.month.toString() +
                                  date.year.toString();
                              startDateToInt = int.parse(dateString);
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
                            '${endDate?.toLocal()}'.split(' ')[0],
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                              icon: const Icon(Icons.apps_outlined),
                              onPressed: () async {
                                endDate = await getDate(_selectedDate);
                                String formattedString = endDate.toString();
                                DateTime date =
                                    DateTime.parse(formattedString);
                                String dateString = date.day.toString() +
                                    date.month.toString() +
                                    date.year.toString();
                                endDateToInt = int.parse(dateString);
                              })
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
                          itemBuilder: (BuildContext context) =>
                              List.generate(
                                4,
                                (index) => PopupMenuItem(
                                    child:
                                        Text(employeeList.elementAt(index)),
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
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);

                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(fontSize: 20,color: Colors.blueGrey),
                      )),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                    ),
                    child: const Text(
                      'APPLY',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      LeaveRequestData leaveRequestData = LeaveRequestData(
                          startDate: startDateToInt,
                          endDate: endDateToInt,
                          totalLeaves: 2.0,
                          reason: _textEditingController.text,
                          emergencyContactPerson: selectedEmployeeId);

                      await _apiService.applyForLeave(leaveRequestData);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmployeeAllLeaves()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  List<String> employeeList = ['Sneha', 'Radhi', 'Jimmy', 'Ami'];
  List<int> employeeID = [0, 1, 2, 3];

  Future<DateTime?> getDate(DateTime selectedDate) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (date != null && date != selectedDate) {
      setState(() {
        selectedDate = date;
      });
    }
    return date;
  }
}
