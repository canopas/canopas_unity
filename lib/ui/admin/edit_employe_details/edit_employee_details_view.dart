import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/event_bus/events.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/edit_employee_details_bloc.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/edit_employee_details_events.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/admin/edit_employe_details/widgets/admin_edit_employee_details_form.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_event.dart';
import '../../../configs/colors.dart';
import '../../../widget/circular_progress_indicator.dart';
import 'bloc/edit_employee_details_state.dart';

class AdminEditEmployeeDetailsPage extends StatelessWidget {
  final Employee employee;

  const AdminEditEmployeeDetailsPage({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminEditEmployeeDetailsBloc>()
        ..add(AdminEditEmployeeDetailsInitialEvent(
            roleType: employee.roleType, joiningDate: employee.dateOfJoining)),
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
  final TextEditingController dateOfJoiningFieldController =
      TextEditingController();

  @override
  void initState() {
    nameFieldController.text = widget.employee.name;
    emailFieldController.text = widget.employee.email;
    designationFieldController.text = widget.employee.designation;
    levelFieldController.text = widget.employee.level ?? "";
    employeeIDFieldController.text = widget.employee.employeeId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).edit_tag),
      ),
      body: AdminEditEmployeeDetailsForm(
          employeeId: widget.employee.id,
          nameFieldController: nameFieldController,
          dateOfJoiningFieldController: dateOfJoiningFieldController,
          designationFieldController: designationFieldController,
          emailFieldController: emailFieldController,
          employeeIDFieldController: employeeIDFieldController,
          levelFieldController: levelFieldController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
        child: BlocBuilder<AdminEditEmployeeDetailsBloc,
          AdminEditEmployeeDetailsState>(
          buildWhen: (previous, current) => previous.isValid != current.isValid,
          builder: (context, state) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 45),
                disabledBackgroundColor: AppColors.greyColor,
              ),
              onPressed: (state.isValid)?() {
                context.read<AdminEditEmployeeDetailsBloc>().add(UpdateEmployeeDetailsAdminEditEmployeeDetailsEvents(
                  id: widget.employee.id,
                  name: nameFieldController.text,
                  email: emailFieldController.text,
                  designation: designationFieldController.text,
                  level: levelFieldController.text,
                  employeeId: employeeIDFieldController.text,
                ));
              }:null,
              child: state.adminEditEmployeeDetailsStatus == AdminEditEmployeeDetailsStatus.loading
              ?const AppCircularProgressIndicator(size: 20,):Text(AppLocalizations.of(context).update_button_text,style: AppTextStyle.subtitleTextWhite,)),
        ),
      ),
    );
  }
}
