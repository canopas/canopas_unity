import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/utils/const/color_constant.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';

import '../../../../bloc/employee_detail_bloc.dart';
import '../../../../di/service_locator.dart';
import '../../../../model/employee/employee.dart';
import '../../../../rest/api_response.dart';
import '../../../../widget/error_banner.dart';
import 'widget/profile_card.dart';
import 'widget/profile_detail.dart';

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  final _bloc = getIt<EmployeeDetailBloc>();
  final _navigationStackManager = getIt<NavigationStackManager>();

  @override
  void initState() {
    super.initState();
    _bloc.getEmployeeDetailByID(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _navigationStackManager.pop(),
          icon: const Icon(FontAwesomeIcons.angleLeft, color: Colors.black),
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.ibmPlexSans(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(kSecondaryColor),
      ),
      body: StreamBuilder<ApiResponse<Employee>>(
        stream: _bloc.employeeDetail,
        initialData: const ApiResponse.loading(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data?.when(idle: () {
            return Container();
          }, loading: () {
            return kCircularProgressIndicator;
          }, completed: (Employee employee) {
            return SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                    height: 400,
                    child: ProfileCard(
                      employee: employee,
                    )),
                ProfileDetail(employee: employee),
              ]),
            );
          }, error: (String error) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Something went wrong')));
            });
            return Container();
          });
        },
      ),
    );
  }
}
