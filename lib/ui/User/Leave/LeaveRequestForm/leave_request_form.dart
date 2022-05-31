import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/Contents/select_date_picker.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/Contents/select_leave_type.dart';
import 'package:projectunity/utils/Constant/color_constant.dart';

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({Key? key}) : super(key: key);

  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  DateTime startLeaveDate = DateTime.now();
  DateTime endLeaveDate = DateTime.now();
  bool fullDaySelected = false;
  bool halfDaySelected = true;
  TextEditingController _reasonEditingController = TextEditingController();
  String supervisor = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black54,
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text('Request Leave'),
        titleTextStyle: GoogleFonts.ibmPlexSans(
            color: Colors.black54, fontSize: 19, fontWeight: FontWeight.w600),
        backgroundColor: const Color(appBarColor),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SelectLeaveType(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectDatePicker(date: startLeaveDate),
                  SelectDatePicker(date: endLeaveDate),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(kPrimaryColour)),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        setState(() {
                          fullDaySelected = !fullDaySelected;
                          halfDaySelected = !halfDaySelected;
                        });
                      },
                      child: Text(
                        'Full-day',
                        style: GoogleFonts.ibmPlexSans(color: Colors.black87),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: fullDaySelected
                            ? Colors.white
                            : const Color(kPrimaryColour),
                        onPrimary: Color(kPrimaryColour),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    )),
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        setState(() {
                          fullDaySelected = !fullDaySelected;
                          halfDaySelected = !halfDaySelected;
                        });
                      },
                      child: Text('Half-day',
                          style:
                              GoogleFonts.ibmPlexSans(color: Colors.black87)),
                      style: ElevatedButton.styleFrom(
                        primary: halfDaySelected
                            ? Colors.white
                            : const Color(kPrimaryColour),
                        onPrimary: Color(kPrimaryColour),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ))
                  ],
                ),
              ),
              Card(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  style: GoogleFonts.ibmPlexSans(color: Colors.black87),
                  cursorColor: const Color(kPrimaryColour),
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Reason',
                  ),
                  autofocus: true,
                  controller: _reasonEditingController,
                  keyboardType: TextInputType.text,
                  onChanged: (data) {},
                ),
              )),
              Card(
                child: ListTile(
                  title: Text(
                    'Supervisor',
                    style: GoogleFonts.ibmPlexSans(color: Colors.grey),
                  ),
                  trailing: DropdownButton(
                    underline: Container(),
                    isExpanded: false,
                    focusColor: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    items: leaves.map((String person) {
                      return DropdownMenuItem<String>(
                          value: person,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(person),
                          ));
                    }).toList(),
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: 15, color: Colors.black87),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black87,
                    ),
                    onChanged: (String? value) {
                      supervisor = value!;
                    },
                    value: leaves.first,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
// enum Leave { fullDay, firstHalf, secondHalf }
//
// class LeaveRequestForm extends StatefulWidget {
//   const LeaveRequestForm({Key? key}) : super(key: key);
//
//   @override
//   _LeaveRequestFormState createState() => _LeaveRequestFormState();
// }
//
// class _LeaveRequestFormState extends State<LeaveRequestForm> {
//   final DateTime _selectedDate = DateTime.now();
//   DateTime? startDate = DateTime.now();
//   DateTime? endDate = DateTime.now();
//   int startDateToInt = 0;
//   int endDateToInt = 0;
//   String selectedName = '';
//   int selectedEmployeeId = 0;
//   late TextEditingController _reasonEditingController;
//   late TextEditingController _leaveEditingController;
//   final ApplyForLeaveApiService _apiService = getIt<ApplyForLeaveApiService>();
//   bool _hasBeenPressed = false;
//   final NavigationStackManager _stateManager = getIt<NavigationStackManager>();
//
//   @override
//   void initState() {
//     super.initState();
//     _reasonEditingController = TextEditingController();
//     _leaveEditingController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _reasonEditingController.dispose();
//     _leaveEditingController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           resizeToAvoidBottomInset: true,
//           body: Padding(
//             padding: const EdgeInsets.all(20),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Apply for Leaves ',
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'From: ',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Card(
//                               child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 2,
//                               ),
//                               Text(
//                                 DateFormat.yMMMd().format(startDate!),
//                                 style: const TextStyle(fontSize: 20),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.apps_outlined),
//                                 onPressed: () async {
//                                   startDate = await getDate(_selectedDate);
//                                   String formattedDate = startDate.toString();
//                                   DateTime date = DateTime.parse(formattedDate);
//                                   startDateToInt = date.microsecondsSinceEpoch;
//                                 },
//                               )
//                             ],
//                           ))
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'To: ',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Card(
//                               child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 2,
//                               ),
//                               Text(
//                                 DateFormat.yMMMd().format(endDate!),
//                                 style: const TextStyle(fontSize: 20),
//                               ),
//                               IconButton(
//                                   icon: const Icon(Icons.apps_outlined),
//                                   onPressed: () async {
//                                     endDate = await getDate(_selectedDate);
//                                     DateTime date =
//                                         DateTime.parse(endDate.toString());
//
//                                     endDateToInt = date.microsecondsSinceEpoch;
//                                   })
//                             ],
//                           ))
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Total Leaves: ',
//                             style: TextStyle(fontSize: 20),
//                           )),
//                       Expanded(
//                           child: SizedBox(
//                         height: 50,
//                         child: Card(
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: TextFormField(
//                               decoration: const InputDecoration.collapsed(
//                                   hintText: 'leaves'),
//                               keyboardType: TextInputType.number,
//                               controller: _leaveEditingController,
//                             ),
//                           ),
//                         ),
//                       )),
//                     ],
//                   ),
//                   Card(
//                       child: ListTile(
//                           title: const Text(
//                             'You can Contact: ',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           subtitle: Text(
//                             selectedName,
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           trailing: PopupMenuButton(
//                               icon: const Icon(Icons.add),
//                               onSelected: (index) {
//                                 setState(() {
//                                   selectedEmployeeId = index as int;
//                                   selectedName = employeeList
//                                       .elementAt(selectedEmployeeId);
//                                 });
//                               },
//                               itemBuilder: (BuildContext context) =>
//                                   List.generate(
//                                     4,
//                                     (index) => PopupMenuItem(
//                                         child:
//                                             Text(employeeList.elementAt(index)),
//                                         value: employeeID.elementAt(index)),
//                                   )))),
//                   const Text(
//                     "Reason",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             maxLines: 5,
//                             decoration: const InputDecoration.collapsed(
//                               hintText: 'Enter reason',
//                             ),
//                             autofocus: true,
//                             controller: _reasonEditingController,
//                             keyboardType: TextInputType.text,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       OutlinedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                             _hasBeenPressed = !_hasBeenPressed;
//                           },
//                           style: OutlinedButton.styleFrom(
//                               backgroundColor: _hasBeenPressed
//                                   ? Colors.blueGrey
//                                   : Colors.white54),
//                           child: const Text(
//                             'CANCEL',
//                             style:
//                                 TextStyle(fontSize: 20, color: Colors.blueGrey),
//                           )),
//                       ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.blueGrey),
//                         ),
//                         child: const Text(
//                           'APPLY',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         onPressed: () async {
//                           try {
//                             LeaveRequestData leaveRequestData =
//                                 LeaveRequestData(
//                                     startDate: startDateToInt,
//                                     endDate: endDateToInt,
//                                     totalLeaves: double.parse(
//                                         _leaveEditingController.text),
//                                     reason: _reasonEditingController.text,
//                                     emergencyContactPerson: selectedEmployeeId);
//                             await _apiService.applyForLeave(leaveRequestData);
//                             _stateManager.pop();
//                           } on Exception catch (error) {
//                             showErrorBanner('Please fill all details', context);
//                             throw DataException(error.toString());
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
//
//   List<String> employeeList = ['Sneha', 'Radhi', 'Jimmy', 'Ami'];
//   List<int> employeeID = [0, 1, 2, 3];
//
//   Future<DateTime?> getDate(DateTime selectedDate) async {
//     DateTime? date = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(2020),
//         lastDate: DateTime(2030));
//     if (date != null && date != selectedDate) {
//       setState(() {
//         selectedDate = date;
//       });
//     }
//     return date;
//   }
// }
