import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/ui/admin/home/addmember/widget/role_toggle_button.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../widget/date_time_picker.dart';
import '../../../../widget/employee_details_textfield.dart';
import '../bloc/add_member_bloc.dart';
import '../bloc/add_member_event.dart';
import '../bloc/add_member_state.dart';

class AddMemberForm extends StatefulWidget {
  const AddMemberForm({Key? key}) : super(key: key);

  @override
  State<AddMemberForm> createState() => _AddMemberFormState();
}

class _AddMemberFormState extends State<AddMemberForm> {
  late final TextEditingController _dateController;

  @override
  void initState() {
    _dateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AddMemberBloc>(context);
    var localization = AppLocalizations.of(context);
    return BlocBuilder<AddMemberBloc, AddMemberFormState>(
      bloc: BlocProvider.of<AddMemberBloc>(context),
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.only(
            left: primaryHorizontalSpacing,
            right: primaryHorizontalSpacing,
            top: 24,
            bottom: 100,
          ),
          children: [
            ToggleButton(
              role: state.role ?? Role.employee,
              onRoleChange: (role) => bloc.add(SelectRoleEvent(role: role)),
            ),
            const SizedBox(height: 12),
            FieldTitle(title: localization.employee_employeeID_tag),
            FieldEntry(
                onChanged: (value) =>
                    bloc.add(AddEmployeeIdEvent(employeeId: value)),
                errorText: state.idError
                    ? localization
                        .admin_home_add_member_complete_mandatory_field_error
                    : null,
                hintText:
                    localization.admin_home_add_member_employee_id_hint_text),
            FieldTitle(title: localization.employee_name_tag),
            FieldEntry(
              onChanged: (value) => context
                  .read<AddMemberBloc>()
                  .add(AddEmployeeNameEvent(name: value)),
              errorText: state.nameError
                  ? localization.admin_home_add_member_error_name
                  : null,
              hintText: localization.admin_home_add_member_name_hint_text,
            ),
            FieldTitle(title: localization.employee_email_tag),
            FieldEntry(
                onChanged: (value) =>
                    bloc.add(AddEmployeeEmailEvent(email: value)),
                errorText: state.emailError
                    ? localization.admin_home_add_member_error_email
                    : null,
                hintText: localization.admin_home_add_member_email_hint_text),
            FieldTitle(title: localization.employee_designation_tag),
            FieldEntry(
                onChanged: (value) =>
                    bloc.add(AddEmployeeDesignationEvent(designation: value)),
                errorText: state.designationError
                    ? localization
                        .admin_home_add_member_complete_mandatory_field_error
                    : null,
                hintText:
                    localization.admin_home_add_member_designation_hint_text),
            FieldTitle(title: localization.employee_dateOfJoin_tag),
            TextField(
              readOnly: true,
              onTap: () async {
                DateTime? joiningDate = await pickDate(
                    context: context,
                    initialDate: state.dateOfJoining ?? DateTime.now());
                if (joiningDate != null) {
                  bloc.add(AddDateOfJoiningDateEvent(joiningDate));
                  _dateController.text =
                      localization.date_format_yMMMd(joiningDate);
                }
              },
              controller: _dateController,
              keyboardType: TextInputType.none,
              cursorColor: Colors.black,
              autocorrect: false,
              style: AppFontStyle.labelRegular,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(primaryHorizontalSpacing),
                fillColor: AppColors.textFieldBg,
                filled: true,
                hintStyle: AppFontStyle.labelGrey,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                hintText: AppLocalizations.of(context)
                    .date_format_yMMMd(state.dateOfJoining ?? DateTime.now()),
              ),
            ),
          ],
        );
      },
    );
  }
}
