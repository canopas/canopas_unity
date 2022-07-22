import 'package:flutter/material.dart';
import 'package:projectunity/bloc/employee_leave_bloc.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/employee_leave.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/utils/const/other_constant.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../../configs/colors.dart';
import 'leaveRequestCard/leave_request_card.dart';

class AdminLeaveRequestsScreen extends StatefulWidget {
  const AdminLeaveRequestsScreen({Key? key}) : super(key: key);

  @override
  State<AdminLeaveRequestsScreen> createState() =>
      _AdminLeaveRequestsScreenState();
}

class _AdminLeaveRequestsScreenState extends State<AdminLeaveRequestsScreen> {
  final NavigationStackManager _stackManager = getIt<NavigationStackManager>();
  final EmployeeLeaveBloc _employeeLeaveBloc = getIt<EmployeeLeaveBloc>();

  @override
  void initState() {
    _employeeLeaveBloc.allLeaves();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.darkText,
          ),
          onPressed: () {
            _stackManager.pop();
          },
        ),
        title: const Text(
          "Requests",
          style: TextStyle(
              color: AppColors.darkText,
              fontSize: headerTextSize,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: primaryHorizontalSpacing,
            right: primaryHorizontalSpacing,
            left: primaryHorizontalSpacing),
        child: StreamBuilder<ApiResponse<List<EmployeeLeave>>>(
            initialData: const ApiResponse.idle(),
            stream: _employeeLeaveBloc.requests,
            builder: (context, snapshot) {
              return snapshot.data!.when(
                  idle: () => Container(),
                  loading: () => const kCircularProgressIndicator(),
                  completed: (List<EmployeeLeave> list) {
                    return ListView.separated(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        EmployeeLeave employeeLeave = list[index];
                        return LeaveRequestCard(employeeLeave: employeeLeave);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    );
                  },
                  error: (String error) {
                    return buildSnackBar(context, error);
                  });
            }),
      ),
    );
  }
}
