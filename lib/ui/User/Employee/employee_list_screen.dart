import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/utils/Constant/color_constant.dart';
import 'package:projectunity/utils/Constant/image_constant.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColour).withOpacity(.5),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.height / 100 * 5,
                      backgroundImage: const AssetImage(profileImage),
                    ),
                    Text(
                      'Hi, Sneha!',
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 30,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade200),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              cursorColor: Colors.black54,
                              style: GoogleFonts.ibmPlexSans(
                                  fontSize: 20, color: Colors.black87),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                hintText: 'Search',
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      )
                    ],
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

// class EmployeeListScreen extends StatefulWidget {
//   const EmployeeListScreen({Key? key}) : super(key: key);
//
//   @override
//   _EmployeeListScreenState createState() => _EmployeeListScreenState();
// }
//
// class _EmployeeListScreenState extends State<EmployeeListScreen> {
//   final _bloc = getIt<EmployeeListBloc>();
//   final _userManager = getIt<UserManager>();
//   AppStateManager appStateManager = getIt<AppStateManager>();
//
//   @override
//   void initState() {
//     super.initState();
//     _bloc.getEmployeeList();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return   Scaffold(
//       backgroundColor: Colors.blueGrey.shade200,
//       body: SafeArea(
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _userManager.getUserImage() == null
//               ? const Icon(
//                   Icons.account_circle_rounded,
//                   size: 50,
//                 )
//               : ImageIcon(
//                   NetworkImage(_userManager.getUserImage()!),
//                   size: 50,
//                 ),
//           IconButton(
//             icon: const Icon(Icons.search),
//             iconSize: 30,
//             onPressed: () {},
//           )
//         ],
//             ),
//             Text(
//         _userManager.getUserName() ?? '',
//         style: const TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             fontStyle: FontStyle.normal),
//             ),
//             const Text(
//           'Know your colleague,find their contact information and get in touch with him/her ',
//           style: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//               fontSize: 20)),
//             StreamBuilder<ApiResponse<List<Employee>>>(
//           initialData: const ApiResponse.idle(),
//           stream: _bloc.allEmployee,
//           builder:
//               (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             return snapshot.data!.when(idle: () {
//               return Container();
//             }, loading: () {
//               return const Center(child: CircularProgressIndicator());
//             }, completed: (List<Employee> list) {
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: list.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   Employee _employee = list[index];
//                   return EmployeeWidget(
//                       employee: _employee,
//                       ontap: () => appStateManager
//                           .onTapOfEmployee(_employee.id));
//                 },
//               );
//             }, error: (String error) {
//               SchedulerBinding.instance.addPostFrameCallback((_) {
//                 showErrorBanner(error, context);
//               });
//
//               return const Center(child: CircularProgressIndicator());
//             });
//           }),
//           ]),
//       ),
//     );
//   }
// }
