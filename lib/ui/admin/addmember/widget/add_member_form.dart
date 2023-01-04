import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/core/utils/const/role.dart';
import 'package:projectunity/ui/admin/addmember/widget/role_toggle_button.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/space_constant.dart';
import '../../../../widget/date_time_picker.dart';
import '../bloc/add_member_bloc.dart';
import '../bloc/add_member_event.dart';
import '../bloc/add_member_state.dart';

class AddMemberForm extends StatelessWidget {
  final TextEditingController _dateController = TextEditingController();

  AddMemberForm({Key? key}) : super(key: key);

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
              role: state.role??kRoleTypeEmployee,
              onRoleChange: (role) => bloc.add(SelectRoleTypeEvent(roleType: role)),
            ),
            TextFieldTitle(
                title: localization.employee_employeeID_tag),
            EmployeeField(
                onChanged: (value) =>
                    bloc.add(AddEmployeeIdEvent(employeeId: value)),
                errorText: state.idError
                    ? localization.admin_add_member_error_complete_field
                    : null,
                hintText: localization.admin_addMember_hint_employeeId),
            TextFieldTitle(title: localization.employee_name_tag),
            EmployeeField(
              onChanged: (value) => context
                  .read<AddMemberBloc>()
                  .add(AddEmployeeNameEvent(name: value)),
              errorText: state.nameError
                  ? localization.admin_add_member_error_name
                  : null,
              hintText: localization.admin_addMember_hint_name,
            ),
            TextFieldTitle(title: localization.employee_email_tag),
            EmployeeField(
                onChanged: (value) =>
                    bloc.add(AddEmployeeEmailEvent(email: value)),
                errorText: state.emailError
                    ? localization.admin_add_member_error_email
                    : null,
                hintText: localization.admin_addMember_hint_email),
            TextFieldTitle(
                title: localization.employee_designation_tag),
            EmployeeField(
                onChanged: (value) => bloc
                    .add(AddEmployeeDesignationEvent(designation: value)),
                errorText: state.designationError
                    ? localization.admin_add_member_error_complete_field
                    : null,
                hintText: localization.admin_addMember_hint_designation),
            TextFieldTitle(
                title: localization.employee_dateOfJoin_tag),
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
              style: AppTextStyle.subtitleTextDark,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintStyle: AppTextStyle.secondarySubtitle500,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                hintText: AppLocalizations.of(context).date_format_yMMMd(
                    state.dateOfJoining ?? DateTime.now()),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TextFieldTitle extends StatelessWidget {
  final String title;
  const TextFieldTitle({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: AppTextStyle.secondarySubtitle500,
      ),
    );
  }
}

class EmployeeField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? errorText;
  final String hintText;
  final TextEditingController? controller;

  const EmployeeField(
      {Key? key,
      this.onChanged,
      this.errorText,
      required this.hintText,  this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      controller: controller,
      cursorColor: Colors.black,
      autocorrect: false,
      style: AppTextStyle.subtitleTextDark,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        errorText: errorText,
        hintStyle: AppTextStyle.secondarySubtitle500,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hintText,
      ),
    );
  }
}
