import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/utils/Constant/color_constant.dart';

import '../../../Navigation /app_state_manager.dart';
import '../../../ViewModel/employee_list_bloc.dart';
import '../../../Widget/error_banner.dart';
import '../../../di/service_locator.dart';
import '../../../model/Employee/employee.dart';
import '../../../rest/api_response.dart';
import '../../../user/user_manager.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final _bloc = getIt<EmployeeListBloc>();
  final _userManager = getIt<UserManager>();
  AppStateManager appStateManager = getIt<AppStateManager>();

  @override
  void initState() {
    super.initState();
    _bloc.getEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(kPrimaryColour).withOpacity(0.2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, ${_userManager.getUserFullName()}!',
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 30,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Know your team ',
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.grey,
                            letterSpacing: 0.1,
                            fontSize: 17),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: _userManager.getUserImage() == null
                        ? const Icon(
                            Icons.account_circle_rounded,
                            size: 70,
                          )
                        : CircleAvatar(
                            radius: height / 100 * 3,
                            backgroundImage:
                                NetworkImage(_userManager.getUserImage()!)),
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
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        height: 45,
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
                                    ? const TextStyle(fontSize: 20)
                                    : const TextStyle(fontSize: 16)),
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      StreamBuilder<ApiResponse<List<Employee>>>(
                          initialData: const ApiResponse.idle(),
                          stream: _bloc.allEmployee,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            return snapshot.data!.when(idle: () {
                              return Container();
                            }, loading: () {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }, completed: (List<Employee> list) {
                              return Expanded(
                                  child: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Employee _employee = list[index];
                                  return Material(
                                    color: Colors.white54,
                                    child: InkWell(
                                      onTap: () {
                                        print('${_employee.id} is tapped!');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  _employee.imageUrl == null
                                                      ? const Icon(
                                                          Icons
                                                              .account_circle_rounded,
                                                          size: 70,
                                                        )
                                                      : CircleAvatar(
                                                          radius: height /
                                                              100 *
                                                              3.5,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  _employee
                                                                      .imageUrl!)),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _employee.name ?? '',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: height >= 700
                                                            ? GoogleFonts
                                                                .ibmPlexSans(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)
                                                            : GoogleFonts
                                                                .ibmPlexSans(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                      ),
                                                      const SizedBox(
                                                        height: 7,
                                                      ),
                                                      Text(
                                                        _employee.designation!,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: height >= 700
                                                            ? GoogleFonts
                                                                .ibmPlexSans(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .black54)
                                                            : GoogleFonts
                                                                .ibmPlexSans(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black54),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            //  const  Divider(color: Colors.grey,indent: 80,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ));
                            }, error: (String error) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                showErrorBanner(error, context);
                              });

                              return const Center(
                                  child: CircularProgressIndicator());
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
