import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/bloc/admin/employee/employee_validation.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/admin/addmember/widget/role_toggle_button.dart';
import '../../../../core/utils/const/other_constant.dart';
import '../../../../core/utils/const/role.dart';

class EmployeeForm extends StatefulWidget {
  int selectedRole;

  EmployeeForm({Key? key, required this.selectedRole}) : super(key: key);

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final EmployeeValidationBloc _bloc = getIt<EmployeeValidationBloc>();

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      child: ListView(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30,
          top: 40,
        ),
        children: [
          ToggleButton(
            onRoleChange: (role) {
              switch (role) {
                case kRoleTypeEmployee:
                  setState(() {
                    widget.selectedRole = kRoleTypeEmployee;
                  });
                  break;
                case kRoleTypeHR:
                  setState(() {
                    widget.selectedRole = kRoleTypeHR;
                  });
              }
            },
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(title: _localization.employee_employeeID_tag),
                CustomTextField(
                    hintText: _localization.admin_addMember_hint_employeeId,
                    stream: _bloc.employeeId,
                    onChanged: (employeeId) =>
                        _bloc.validateEmployeeId(employeeId, context)),
                TitleText(title: _localization.employee_name_tag),
                CustomTextField(
                    hintText: _localization.admin_addMember_hint_name,
                    stream: _bloc.name,
                    onChanged: (name) => _bloc.validateName(name, context)),
                TitleText(title: _localization.employee_email_tag),
                CustomTextField(
                    hintText: _localization.admin_addMember_hint_email,
                    stream: _bloc.email,
                    onChanged: (email) =>
                        _bloc.validateEmail(email, context)),
                TitleText(title: _localization.employee_designation_tag),
                CustomTextField(
                    hintText:
                        _localization.admin_addMember_hint_designation,
                    stream: _bloc.designation,
                    onChanged: (designation) =>
                        _bloc.validateDesignation(designation, context)),
                Container(
                  height: 200,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String title;

  const TitleText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(top: primaryHorizontalSpacing, bottom: primaryVerticalSpacing),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: AppTextStyle.secondarySubtitle500,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  Stream<String>? stream;
  final String hintText;
  void Function(String) onChanged;

  CustomTextField(
      {Key? key,
      required this.stream,
      required this.onChanged,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          cursorColor: Colors.black,
          autocorrect: false,
          style:  AppTextStyle.subtitleTextDark,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
            hintStyle: AppTextStyle.secondarySubtitle500,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: hintText,
          ),
        );
      },
    );
  }
}
