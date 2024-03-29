import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../../data/di/service_locator.dart';
import '../../../../../data/provider/user_state.dart';
import '../../../../widget/date_time_picker.dart';
import '../../../../widget/employee_details_textfield.dart';
import '../../../../widget/error_snack_bar.dart';
import '../../../../widget/pick_profile_image/pick_user_profile_image.dart';
import 'role_toggle_button.dart';
import '../bloc/admin_edit_employee_bloc.dart';
import '../bloc/admin_edit_employee_events.dart';
import '../bloc/admin_edit_employee_state.dart';

class AdminEditEmployeeDetailsForm extends StatelessWidget {
  final String employeeId;
  final String? profileImageUrl;
  final TextEditingController nameFieldController;
  final TextEditingController emailFieldController;
  final TextEditingController designationFieldController;
  final TextEditingController levelFieldController;
  final TextEditingController employeeIDFieldController;

  const AdminEditEmployeeDetailsForm(
      {super.key,
      required this.profileImageUrl,
      required this.employeeId,
      required this.nameFieldController,
      required this.emailFieldController,
      required this.designationFieldController,
      required this.levelFieldController,
      required this.employeeIDFieldController});

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    final bloc = context.read<AdminEditEmployeeDetailsBloc>();
    return BlocListener<AdminEditEmployeeDetailsBloc,
        AdminEditEmployeeDetailsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.error) {
          showSnackBar(context: context, error: state.error);
        } else if (state.status == Status.success) {
          context.pop();
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        children: [
          ProfileImagePicker(
            imageURl: profileImageUrl,
            onPickImageChange: (String image) => context
                .read<AdminEditEmployeeDetailsBloc>()
                .add(ChangeProfileImageEvent(image)),
          ),
          ValidateWidget(
            isValid: getIt<UserStateNotifier>().isAdmin,
            child: BlocBuilder<AdminEditEmployeeDetailsBloc,
                AdminEditEmployeeDetailsState>(
              buildWhen: (previous, current) => previous.role != current.role,
              builder: (context, state) => ToggleButton(
                  onRoleChange: (role) {
                    if (role != null) {
                      context
                          .read<AdminEditEmployeeDetailsBloc>()
                          .add(ChangeEmployeeRoleEvent(roleType: role));
                    }
                  },
                  role: state.role),
            ),
          ),
          FieldTitle(title: localization.employee_employeeID_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.employeeIdError != current.employeeIdError,
            builder: (context, state) => FieldEntry(
                controller: employeeIDFieldController,
                onChanged: (value) =>
                    bloc.add(ChangeEmployeeIdEvent(employeeId: value)),
                errorText: state.employeeIdError
                    ? localization
                        .admin_home_add_member_complete_mandatory_field_error
                    : null,
                hintText:
                    localization.admin_home_add_member_employee_id_hint_text),
          ),
          FieldTitle(title: localization.employee_name_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.nameError != current.nameError,
            builder: (context, state) => FieldEntry(
              controller: nameFieldController,
              onChanged: (value) =>
                  bloc.add(ChangeEmployeeNameEvent(name: value)),
              errorText: state.nameError
                  ? localization.admin_home_add_member_name_hint_text
                  : null,
              hintText: localization.admin_home_add_member_name_hint_text,
            ),
          ),
          FieldTitle(title: localization.employee_email_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.emailError != current.emailError,
            builder: (context, state) => FieldEntry(
                controller: emailFieldController,
                onChanged: (value) =>
                    bloc.add(ChangeEmployeeEmailEvent(email: value)),
                errorText: state.emailError
                    ? localization.admin_home_add_member_error_email
                    : null,
                hintText: localization.admin_home_add_member_email_hint_text),
          ),
          FieldTitle(title: localization.employee_designation_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
              AdminEditEmployeeDetailsState>(
            buildWhen: (previous, current) =>
                previous.designationError != current.designationError,
            builder: (context, state) => FieldEntry(
                controller: designationFieldController,
                onChanged: (value) => bloc
                    .add(ChangeEmployeeDesignationEvent(designation: value)),
                errorText: state.designationError
                    ? localization
                        .admin_home_add_member_complete_mandatory_field_error
                    : null,
                hintText:
                    localization.admin_home_add_member_designation_hint_text),
          ),
          FieldTitle(title: localization.employee_level_tag),
          FieldEntry(
              controller: levelFieldController,
              hintText: localization.admin_home_add_member_level_hint_text),
          FieldTitle(title: localization.employee_dateOfJoin_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
                  AdminEditEmployeeDetailsState>(
              buildWhen: (previous, current) =>
                  previous.dateOfJoining != current.dateOfJoining,
              builder: (context, state) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shadowColor: context.colorScheme.containerNormal,
                    surfaceTintColor: context.colorScheme.containerNormal,
                    foregroundColor: context.colorScheme.textPrimary,
                    alignment: Alignment.centerLeft,
                    backgroundColor: context.colorScheme.containerNormal,
                    fixedSize: Size(MediaQuery.of(context).size.height, 53),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () async {
                    DateTime? joiningDate = await pickDate(
                        context: context,
                        initialDate: state.dateOfJoining ?? DateTime.now());
                    bloc.add(ChangeEmployeeDateOfJoiningEvent(
                        dateOfJoining: joiningDate ??
                            state.dateOfJoining ??
                            DateTime.now()));
                  },
                  child: Text(
                    localization.date_format_yMMMd(
                        state.dateOfJoining ?? DateTime.now()),
                    style: AppTextStyle.style16,
                  ))),
          FieldTitle(title: localization.employee_dateOfBirth_tag),
          BlocBuilder<AdminEditEmployeeDetailsBloc,
                  AdminEditEmployeeDetailsState>(
              buildWhen: (previous, current) =>
                  previous.dateOfBirth != current.dateOfBirth,
              builder: (context, state) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shadowColor: context.colorScheme.containerNormal,
                    surfaceTintColor: context.colorScheme.containerNormal,
                    foregroundColor: context.colorScheme.textPrimary,
                    alignment: Alignment.centerLeft,
                    backgroundColor: context.colorScheme.containerNormal,
                    fixedSize: Size(MediaQuery.of(context).size.height, 53),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () async {
                    DateTime? birthDate = await pickDate(
                        context: context,
                        initialDate: state.dateOfJoining ?? DateTime.now());
                    bloc.add(ChangeEmployeeDateOfJoiningEvent(
                        dateOfJoining:
                            birthDate ?? state.dateOfBirth ?? DateTime.now()));
                  },
                  child: Text(
                    localization
                        .date_format_yMMMd(state.dateOfBirth ?? DateTime.now()),
                    style: AppTextStyle.style16,
                  ))),
        ],
      ),
    );
  }
}
