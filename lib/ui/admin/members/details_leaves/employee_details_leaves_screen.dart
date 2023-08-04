import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/admin/members/details_leaves/widget/leave_list.dart';
import '../../../../data/di/service_locator.dart';
import 'bloc/admin_employee_details_leave_bloc.dart';
import 'bloc/admin_employee_details_leave_events.dart';

class AdminEmployeeDetailsLeavesPage extends StatelessWidget {
  final String employeeName;
  final String employeeId;

  const AdminEmployeeDetailsLeavesPage(
      {Key? key, required this.employeeName, required this.employeeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminEmployeeDetailsLeavesBLoc>()
        ..add(LoadInitialLeaves(employeeId: employeeId)),
      child: AdminEmployeeDetailsLeavesScreen(employeeName: employeeName),
    );
  }
}

class AdminEmployeeDetailsLeavesScreen extends StatefulWidget {
  final String employeeName;

  const AdminEmployeeDetailsLeavesScreen({Key? key, required this.employeeName})
      : super(key: key);

  @override
  State<AdminEmployeeDetailsLeavesScreen> createState() =>
      _AdminEmployeeDetailsLeavesScreenState();
}

class _AdminEmployeeDetailsLeavesScreenState
    extends State<AdminEmployeeDetailsLeavesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(AppLocalizations.of(context).employee_details_leaves_title(
            widget.employeeName.split(" ").first)),
      ),
      body: EmployeeLeaveList(employeeName: widget.employeeName),
    );
  }
}
