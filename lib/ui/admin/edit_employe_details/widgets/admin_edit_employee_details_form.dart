import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/ui/admin/addmember/widget/role_toggle_button.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_bloc.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_events.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import '../../../../configs/colors.dart';
import '../../../../widget/date_time_picker.dart';
import '../../../../widget/employee_details_textfield.dart';

class AdminEditEmployeeDetailsForm extends StatelessWidget {
  final String employeeId;
  final TextEditingController nameFieldController;
  final TextEditingController emailFieldController;
  final TextEditingController designationFieldController;
  final TextEditingController levelFieldController;
  final TextEditingController employeeIDFieldController;

  const AdminEditEmployeeDetailsForm(
      {Key? key,
      required this.employeeId,
      required this.nameFieldController,
      required this.emailFieldController,
      required this.designationFieldController,
      required this.levelFieldController,
      required this.employeeIDFieldController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final bloc = context.read<AdminEditEmployeeDetailsBloc>();
    return BlocListener<AdminEditEmployeeDetailsBloc,
        AdminEditEmployeeDetailsState>(
      listener: (context, state) {
        if (state.adminEditEmployeeDetailsStatus ==
            AdminEditEmployeeDetailsStatus.failure) {
          showSnackBar(context: context, error: state.error);
        } else if (state.adminEditEmployeeDetailsStatus ==
            AdminEditEmployeeDetailsStatus.success) {
          context.pop();
        }
      },
      child: ListView(
        padding:
            const EdgeInsets.all(primaryHorizontalSpacing).copyWith(bottom: 80),
        children: [
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.roleType != current.roleType,
            builder: (context, state) => ToggleButton(
                onRoleChange: (role) {
                  context.read<AdminEditEmployeeDetailsBloc>().add(
                      ChangeRoleTypeAdminEditEmployeeDetailsEvent(
                          roleType: role));
                },
                role: state.roleType),
          ),
          FieldTitle(title: localization.employee_employeeID_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.employeeIdError != current.employeeIdError,
            builder: (context, state) => FieldEntry(
                controller: employeeIDFieldController,
                onChanged: (value) => bloc.add(
                    ValidEmployeeIdAdminEditEmployeeDetailsEvent(
                        employeeId: value)),
                errorText: state.employeeIdError
                    ? localization.complete_mandatory_field_error
                    : null,
                hintText: localization.employee_id_hint_text),
          ),
          FieldTitle(title: localization.employee_name_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.nameError != current.nameError,
            builder: (context, state) => FieldEntry(
              controller: nameFieldController,
              onChanged: (value) =>
                  bloc.add(ValidNameAdminEditEmployeeDetailsEvent(name: value)),
              errorText: state.nameError
                  ? localization.admin_add_member_error_name
                  : null,
              hintText: localization.name_hint_text,
            ),
          ),
          FieldTitle(title: localization.employee_email_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.emailError != current.emailError,
            builder: (context, state) => FieldEntry(
                controller: emailFieldController,
                onChanged: (value) => bloc
                    .add(ValidEmailAdminEditEmployeeDetailsEvent(email: value)),
                errorText: state.emailError
                    ? localization.admin_add_member_error_email
                    : null,
                hintText: localization.email_hint_text),
          ),
          FieldTitle(title: localization.employee_designation_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.designationError != current.designationError,
            builder: (context, state) => FieldEntry(
                controller: designationFieldController,
                onChanged: (value) => bloc.add(
                    ValidDesignationAdminEditEmployeeDetailsEvent(
                        designation: value)),
                errorText: state.designationError
                    ? localization.complete_mandatory_field_error
                    : null,
                hintText: localization.designation_hint_text),
          ),
          FieldTitle(title: localization.employee_level_tag),
          FieldEntry(
              controller: levelFieldController,
              hintText: localization.level_hint_text),
          FieldTitle(title: localization.employee_dateOfJoin_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
                  AdminEditEmployeeDetailsState>(
              buildWhen: (previous, current) =>
                  previous.dateOfJoining != current.dateOfJoining,
              builder: (context, state) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    backgroundColor: AppColors.textFieldBg,
                    fixedSize: Size(MediaQuery.of(context).size.height, 53),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    DateTime? joiningDate = await pickDate(
                        context: context,
                        initialDate: state.dateOfJoining ?? DateTime.now());
                    bloc.add(ChangeDateOfJoiningAdminEditEmployeeDetailsEvent(
                        dateOfJoining: joiningDate ??
                            state.dateOfJoining ??
                            DateTime.now()));
                  },
                  child: Text(
                    localization.date_format_yMMMd(
                        state.dateOfJoining ?? DateTime.now()),
                    style: AppTextStyle.subtitleTextDark,
                  ))),
        ],
      ),
    );
  }
}
