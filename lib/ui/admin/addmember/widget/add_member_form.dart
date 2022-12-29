import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
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
    return ListView(
      padding: const EdgeInsets.only(
        left: primaryHorizontalSpacing,
        right: primaryHorizontalSpacing,
        top: 24,
        bottom: 100,
      ),
      children: [
        ToggleButton(
          onRoleChange: (role) => bloc.add(SelectRoleTypeEvent(roleType: role)),
        ),
        const SizedBox(height: 12),
        BlocBuilder<AddMemberBloc, AddMemberFormState>(
          bloc: BlocProvider.of<AddMemberBloc>(context),
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TextFieldTitle(
                    title: localization.employee_employeeID_tag),
                EmployeeField(
                    onChanged: (value) =>
                        bloc.add(AddEmployeeIdEvent(employeeId: value)),
                    errorText: state.idError
                        ? localization.admin_add_member_error_complete_field
                        : null,
                    hintText: localization.admin_addMember_hint_employeeId),
                _TextFieldTitle(title: localization.employee_name_tag),
                EmployeeField(
                  onChanged: (value) => context
                      .read<AddMemberBloc>()
                      .add(AddEmployeeNameEvent(name: value)),
                  errorText: state.nameError
                      ? localization.admin_add_member_error_name
                      : null,
                  hintText: localization.admin_addMember_hint_name,
                ),
                _TextFieldTitle(title: localization.employee_email_tag),
                EmployeeField(
                    onChanged: (value) =>
                        bloc.add(AddEmployeeEmailEvent(email: value)),
                    errorText: state.emailError
                        ? localization.admin_add_member_error_email
                        : null,
                    hintText: localization.admin_addMember_hint_email),
                _TextFieldTitle(
                    title: localization.employee_designation_tag),
                EmployeeField(
                    onChanged: (value) => bloc
                        .add(AddEmployeeDesignationEvent(designation: value)),
                    errorText: state.designationError
                        ? localization.admin_add_member_error_complete_field
                        : null,
                    hintText: localization.admin_addMember_hint_designation),
                _TextFieldTitle(
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
        )
      ],
    );
  }
}

class _TextFieldTitle extends StatelessWidget {
  final String title;
  const _TextFieldTitle({Key? key,required this.title}) : super(key: key);

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
  final Function(String) onChanged;
  final String? errorText;
  final String hintText;

  const EmployeeField(
      {Key? key,
      required this.onChanged,
      required this.errorText,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
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
