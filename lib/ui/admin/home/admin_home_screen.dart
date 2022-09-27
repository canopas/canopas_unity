import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/admin/home/request_list/request_list.dart';
import 'package:projectunity/ui/admin/home/widget/employee_summary_card.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'package:projectunity/widget/expanded_app_bar.dart';
import '../../../bloc/admin/admin_home_screen_bloc/admin_home_screen_bloc.dart';
import '../../../configs/colors.dart';
import '../../../exception/error_const.dart';
import '../../../model/employee_summary/employees_summary.dart';
import '../../../rest/api_response.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  final _adminHomeScreenBloc = getIt<AdminHomeScreenBloc>();

  @override
  void initState() {
    _adminHomeScreenBloc.attach();
    super.initState();
  }

  @override
  void dispose() {
    _adminHomeScreenBloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpandedAppBar(
                  content: Row(children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: AppColors.whiteColor,
                    )),
                const Spacer(),
                IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                    ),
                    onPressed: () {
                      _stateManager.push(const AdminNavigationStackItem.addMemberState());
                    }),
                IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: AppColors.whiteColor,
                    ),
                    onPressed: () {
                      _stateManager.push(
                          const AdminNavigationStackItem.adminSettingsState());
                    }),
              ])),
              const SizedBox(height: 66,),
              AdminLeaveRequestsList(leaveApplicationStream: _adminHomeScreenBloc.leaveApplication,),
            ],
          ),
          Positioned(
              top: 100,
              right: 10,
              left: 10,
              child: StreamBuilder(
                initialData: const ApiResponse<EmployeesSummary>.idle(),
                stream: _adminHomeScreenBloc.employeeSummary.stream,
                builder: (context, AsyncSnapshot<ApiResponse<EmployeesSummary>> snapshot) => snapshot.data!.when
                  (idle:  () => EmployeeSummaryCard(employeesSummary: EmployeesSummary()),
                  loading: () => EmployeeSummaryCard(employeesSummary: EmployeesSummary()),
                  completed: (data) => EmployeeSummaryCard(employeesSummary: data),
                  error: (error) {
                    showSnackBar(context: context, error: undefinedError);
                    return EmployeeSummaryCard(employeesSummary: EmployeesSummary());
                  },
                ),
              )),
        ],
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
