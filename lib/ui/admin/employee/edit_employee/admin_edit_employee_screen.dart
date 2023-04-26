import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/ui/admin/employee/edit_employee/widgets/admin_edit_employee_form.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/model/employee/employee.dart';
import 'bloc/admin_edit_employee_bloc.dart';
import 'bloc/admin_edit_employee_events.dart';
import 'bloc/admin_edit_employee_state.dart';

class AdminEditEmployeeDetailsPage extends StatelessWidget {
  final Employee employee;

  const AdminEditEmployeeDetailsPage({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminEditEmployeeDetailsBloc>()
        ..add(EditEmployeeByAdminInitialEvent(
            roleType: employee.role, dateOfJoining: employee.dateOfJoining)),
      child: AdminEditEmployeeDetailsView(
        employee: employee,
      ),
    );
  }
}

class AdminEditEmployeeDetailsView extends StatefulWidget {
  final Employee employee;

  const AdminEditEmployeeDetailsView({Key? key, required this.employee})
      : super(key: key);

  @override
  State<AdminEditEmployeeDetailsView> createState() =>
      _AdminEditEmployeeDetailsViewState();
}

class _AdminEditEmployeeDetailsViewState
    extends State<AdminEditEmployeeDetailsView> {
  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController designationFieldController =
      TextEditingController();
  final TextEditingController levelFieldController = TextEditingController();
  final TextEditingController employeeIDFieldController =
      TextEditingController();

  @override
  void initState() {
    nameFieldController.text = widget.employee.name;
    emailFieldController.text = widget.employee.email;
    designationFieldController.text = widget.employee.designation ?? '';
    levelFieldController.text = widget.employee.level ?? "";
    employeeIDFieldController.text = widget.employee.employeeId ?? '';
    super.initState();
  }

  @override
  void dispose() {
    nameFieldController.dispose();
    emailFieldController.dispose();
    designationFieldController.dispose();
    levelFieldController.dispose();
    employeeIDFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).edit_tag),
        actions: [
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.isValid != current.isValid ||
                previous.adminEditEmployeeDetailsStatus !=
                    current.adminEditEmployeeDetailsStatus,
            builder: (context, state) => state.adminEditEmployeeDetailsStatus ==
                    AdminEditEmployeeDetailsStatus.loading
                ? const Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: AppCircularProgressIndicator(size: 20),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                        onPressed: state.isValid
                            ? () {
                                context
                                    .read<AdminEditEmployeeDetailsBloc>()
                                    .add(UpdateEmployeeByAdminEvent(
                                      previousEmployeeData: widget.employee,
                                      name: nameFieldController.text,
                                      level: levelFieldController.text,
                                      employeeId:
                                          employeeIDFieldController.text,
                                      email: emailFieldController.text,
                                      designation:
                                          designationFieldController.text,
                                    ));
                              }
                            : null,
                        child: Text(AppLocalizations.of(context).save_tag)),
                  ),
          )
        ],
      ),
      body: AdminEditEmployeeDetailsForm(
        employeeId: widget.employee.uid,
        designationFieldController: designationFieldController,
        emailFieldController: emailFieldController,
        employeeIDFieldController: employeeIDFieldController,
        levelFieldController: levelFieldController,
        nameFieldController: nameFieldController,
      ),
    );
  }
}
