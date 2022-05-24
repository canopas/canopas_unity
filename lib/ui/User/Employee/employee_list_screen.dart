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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(kPrimaryColour).withOpacity(0.4),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: height / 100 * 5,
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
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade200),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              cursorColor: Colors.black54,
                              style: GoogleFonts.ibmPlexSans(
                                  fontSize: 20, color: Colors.black87),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Search your Colleagues by name',
                                  hintStyle: height >= 700
                                      ? TextStyle(fontSize: 20)
                                      : TextStyle(fontSize: 16)),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: height / 100 * 3.5,
                                        backgroundImage:
                                            const AssetImage(profileImage),
                                      ),
                                      SizedBox(
                                        width: width / 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Sneha Sanghani',
                                            textAlign: TextAlign.start,
                                            style: height >= 700
                                                ? GoogleFonts.ibmPlexSans(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500)
                                                : GoogleFonts.ibmPlexSans(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            'Flutter developer',
                                            textAlign: TextAlign.start,
                                            style: height >= 700
                                                ? GoogleFonts.ibmPlexSans(
                                                    fontSize: 18,
                                                    color: Colors.black54)
                                                : GoogleFonts.ibmPlexSans(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                //   const  Divider(color: Colors.grey,indent: 80,)
                              ),
                            );
                          },
                        ))
                      ],
                    ),
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
