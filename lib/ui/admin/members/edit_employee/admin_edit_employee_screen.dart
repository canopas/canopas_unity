import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/admin/members/edit_employee/widgets/admin_edit_employee_form.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import '../../../../data/model/employee/employee.dart';
import 'bloc/admin_edit_employee_bloc.dart';
import 'bloc/admin_edit_employee_events.dart';
import 'bloc/admin_edit_employee_state.dart';

class AdminEditEmployeeDetailsPage extends StatelessWidget {
  final Employee employee;

  const AdminEditEmployeeDetailsPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminEditEmployeeDetailsBloc>()
        ..add(EditEmployeeByAdminInitialEvent(
            roleType: employee.role,
            dateOfJoining: employee.dateOfJoining,
            dateOfBirth: employee.dateOfBirth)),
      child: AdminEditEmployeeDetailsView(
        employee: employee,
      ),
    );
  }
}

class AdminEditEmployeeDetailsView extends StatefulWidget {
  final Employee employee;

  const AdminEditEmployeeDetailsView({super.key, required this.employee});

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
    return AppPage(
      backGroundColor: context.colorScheme.surface,
      title: context.l10n.edit_tag,
      actions: [
        BlocBuilder<AdminEditEmployeeDetailsBloc,
            AdminEditEmployeeDetailsState>(
          buildWhen: (previous, current) =>
              previous.isValid != current.isValid ||
              previous.status != current.status,
          builder: (context, state) => state.status == Status.loading
              ? const AppCircularProgressIndicator(size: 20)
              : TextButton(
                  onPressed: state.isValid
                      ? () {
                          context
                              .read<AdminEditEmployeeDetailsBloc>()
                              .add(UpdateEmployeeByAdminEvent(
                                previousEmployeeData: widget.employee,
                                name: nameFieldController.text,
                                level: levelFieldController.text,
                                employeeId: employeeIDFieldController.text,
                                email: emailFieldController.text,
                                designation: designationFieldController.text,
                              ));
                        }
                      : null,
                  child: Text(
                    context.l10n.save_tag,
                    style: AppTextStyle.style16
                        .copyWith(color: context.colorScheme.primary),
                  )),
        )
      ],
      body: AdminEditEmployeeDetailsForm(
        profileImageUrl: widget.employee.imageUrl,
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
