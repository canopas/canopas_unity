import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/Contents/end_leave.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/Contents/leave_type_card.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/Contents/reason_card.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/Contents/start_leave.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/Contents/supervisor_card.dart';
import 'package:projectunity/utils/Constant/color_constant.dart';

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({Key? key}) : super(key: key);

  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  DateTime startLeaveDate = DateTime.now();
  DateTime endLeaveDate = DateTime.now();
  TimeOfDay startLeaveTime = TimeOfDay.now();
  TimeOfDay endLeaveTime = TimeOfDay.now();
  String? leaveType;
  int? employeeId;

  final TextEditingController _reasonEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black54,
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text('Request Leave'),
        titleTextStyle: GoogleFonts.ibmPlexSans(
            color: Colors.black54, fontSize: 22, fontWeight: FontWeight.w600),
        backgroundColor: const Color(appBarColor),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Stack(children: [
            SizedBox(
              //  height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveTypeCard(leaveType: leaveType),
                    StartLeave(
                      time: startLeaveTime,
                      date: startLeaveDate,
                    ),
                    EndLeave(time: endLeaveTime, date: endLeaveDate),
                    ReasonCard(controller: _reasonEditingController),
                    SupervisorCard(
                      employeeId: employeeId,
                    ),
                    Container(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Reset',
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.black54,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        primary: const Color(kPrimaryColour),
                        onPrimary: const Color(kPrimaryColour),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Apply Leave',
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.black54,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        primary: const Color(kPrimaryColour),
                        onPrimary: const Color(kPrimaryColour),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
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
