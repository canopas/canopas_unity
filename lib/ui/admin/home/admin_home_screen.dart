import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/bloc/employee_list_bloc.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/navigation/navigation_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/ui/user/employee/employeeList/widget/employee_card.dart';
import 'package:projectunity/utils/const/color_constant.dart';
import 'package:projectunity/widget/app_bar.dart';
import 'package:projectunity/widget/error_banner.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  final _bloc = getIt<EmployeeListBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.getEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: width,
          height: 180.0,
          decoration: const BoxDecoration(
            color: primaryBlue,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(100, 6),
                bottomRight: Radius.elliptical(100, 6)),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(
                title: 'Employee Summary',
                onActionPressed: () {
                  _stateManager.setBottomBar(false);
                  _stateManager
                      .push(const NavigationStackItem.addMemberState());
                }),
            const SizedBox(height: 50),
            _buildSummaryView(),
            const SizedBox(height: 24),
            _buildYourEmployeeHeader(),
            Expanded(child: _buildEmployeeListView())
          ],
        ),
      ],
    ));
  }

  Widget _buildSummaryView() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Card(
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSummaryContent(
                    const Icon(
                      Icons.people,
                      size: 26,
                      color: primaryGreen,
                    ),
                    "60",
                    "Employee"),
                _buildSummaryContent(
                    const Icon(
                      Icons.notifications_active_rounded,
                      size: 26,
                      color: primaryDarkYellow,
                    ),
                    "1",
                    "Leave Request"),
                _buildSummaryContent(
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 26,
                      color: primaryPink,
                    ),
                    "2",
                    "Absence"),
              ],
            ),
          )),
    );
  }

  Widget _buildSummaryContent(Widget icon, String title, String desc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        Text(desc,
            style: GoogleFonts.ibmPlexSans(fontSize: 16, color: secondaryText)),
        Text(title,
            style: GoogleFonts.ibmPlexSans(
                fontSize: 20, color: darkText, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildEmployeeListView() {
    return StreamBuilder<ApiResponse<List<Employee>>>(
        initialData: const ApiResponse.idle(),
        stream: _bloc.allEmployee,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data!.when(idle: () {
            return Container();
          }, loading: () {
            return const SizedBox(
                child: Center(
                    child: CircularProgressIndicator(
                      color: primaryBlue,
            )));
          }, completed: (List<Employee> list) {
            return _buildEmployeeList(employees: list);
          }, error: (String error) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showErrorBanner(error, context);
            });

            return Container();
          });
        });
  }

  Widget _buildEmployeeList({required List<Employee> employees}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: employees.length,
      itemBuilder: (context, index) {
        Employee employee = employees[index];
        return EmployeeCard(employee: employee);
      },
    );
  }

  Widget _buildYourEmployeeHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Text("Your Employee",
          style: GoogleFonts.ibmPlexSans(
              fontSize: 24, color: darkText, fontWeight: FontWeight.bold)),
    );
  }
}
