import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/ui/admin/addmember/widget/role_toggle_button.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_bloc.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_events.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../configs/text_style.dart';
import '../../../../event_bus/events.dart';
import '../../../../widget/date_time_picker.dart';
import '../../addmember/widget/add_member_form.dart';
import '../../employee/detail/bloc/employee_detail_event.dart';


class AdminEditEmployeeDetailsForm extends StatelessWidget {
  final String employeeId;
  final TextEditingController nameFieldController;
  final TextEditingController emailFieldController;
  final TextEditingController designationFieldController;
  final TextEditingController levelFieldController;
  final TextEditingController employeeIDFieldController;
  final TextEditingController dateOfJoiningFieldController;

  const AdminEditEmployeeDetailsForm(
      {Key? key,
        required this.nameFieldController,
        required this.emailFieldController,
        required this.designationFieldController,
        required this.levelFieldController,
        required this.employeeIDFieldController,
        required this.dateOfJoiningFieldController, required this.employeeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final bloc = context.read<AdminEditEmployeeDetailsBloc>();
    return BlocConsumer<AdminEditEmployeeDetailsBloc,
        AdminEditEmployeeDetailsState>(
      listener: (context, state) {
        if (state.adminEditEmployeeDetailsStatus == AdminEditEmployeeDetailsStatus.failure){
          showSnackBar(context: context,error: state.error);
        } else if(state.adminEditEmployeeDetailsStatus == AdminEditEmployeeDetailsStatus.success){
          eventBus.fire(EmployeeDetailInitialLoadEvent(employeeId: employeeId));
          context.pop();
        }
      },
      builder: (context, state) {
        dateOfJoiningFieldController.text = localization
            .date_format_yMMMd(state.dateOfJoining ?? DateTime.now().dateOnly);
        return ListView(
          padding: const EdgeInsets.all(primaryHorizontalSpacing)
              .copyWith(bottom: 80),
          children: [
            ToggleButton(
                onRoleChange: (role) {
                  context.read<AdminEditEmployeeDetailsBloc>().add(
                      ChangeRoleTypeAdminEditEmployeeDetailsEvent(
                          roleType: role));
                },
                role: state.roleType),
            FieldTitle(title: localization.employee_employeeID_tag),
            FieldEntry(
                controller: employeeIDFieldController,
                onChanged: (value) => bloc.add(
                    ValidEmployeeIdAdminEditEmployeeDetailsEvent(
                        employeeId: value)),
                errorText: state.employeeIdError
                    ? localization.admin_add_member_error_complete_field
                    : null,
                hintText: localization.admin_addMember_hint_employeeId),
            FieldTitle(title: localization.employee_name_tag),
            FieldEntry(
              controller: nameFieldController,
              onChanged: (value) => bloc
                  .add(ValidNameAdminEditEmployeeDetailsEvent(name: value)),
              errorText: state.nameError
                  ? localization.admin_add_member_error_name
                  : null,
              hintText: localization.admin_addMember_hint_name,
            ),
            FieldTitle(title: localization.employee_email_tag),
            FieldEntry(
                controller: emailFieldController,
                onChanged: (value) => bloc.add(
                    ValidEmailAdminEditEmployeeDetailsEvent(email: value)),
                errorText: state.emailError
                    ? localization.admin_add_member_error_email
                    : null,
                hintText: localization.admin_addMember_hint_email),
            FieldTitle(title: localization.employee_designation_tag),
            FieldEntry(
                controller: designationFieldController,
                onChanged: (value) => bloc.add(
                    ValidDesignationAdminEditEmployeeDetailsEvent(
                        designation: value)),
                errorText: state.designationError
                    ? localization.admin_add_member_error_complete_field
                    : null,
                hintText: localization.admin_addMember_hint_designation),
            FieldTitle(title: localization.employee_level_tag),
            FieldEntry(
                controller: levelFieldController,
                hintText: localization.admin_addMember_hint_level),
            FieldTitle(title: localization.employee_dateOfJoin_tag),
            TextField(
              readOnly: true,
              onTap: () async {
                DateTime? joiningDate = await pickDate(
                    context: context,
                    initialDate: state.dateOfJoining ?? DateTime.now());
                if (joiningDate != null) {
                  bloc.add(ChangeDateOfJoiningAdminEditEmployeeDetailsEvent(
                      dateOfJoining: joiningDate));
                  dateOfJoiningFieldController.text =
                      localization.date_format_yMMMd(joiningDate);
                }
              },
              controller: dateOfJoiningFieldController,
              keyboardType: TextInputType.none,
              cursorColor: Colors.black,
              autocorrect: false,
              style: AppTextStyle.subtitleTextDark,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintStyle: AppTextStyle.secondarySubtitle500,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: AppLocalizations.of(context)
                    .date_format_yMMMd(DateTime.now()),
              ),
            ),
          ],
        );
      },
    );
  }
}
