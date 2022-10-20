import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/bloc/admin/home/add_memeber_bloc.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../configs/colors.dart';
import '../../../core/utils/const/role.dart';
import '../../../widget/date_time_picker.dart';
import 'widget/role_toggle_button.dart';

class AdminAddMemberScreen extends StatefulWidget {
  const AdminAddMemberScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddMemberScreen> createState() => _AdminAddMemberScreenState();
}

class _AdminAddMemberScreenState extends State<AdminAddMemberScreen> {
  final AddMemberBloc _bloc = getIt<AddMemberBloc>();
  int selectedRole = kRoleTypeEmployee;
  final TextEditingController  _dateController = TextEditingController();

  @override
  void initState() {
    _bloc.addEmployeeStream.listen((event) {
      event.whenOrNull(error: (error) {
        showSnackBar(context: context, error: error.toString());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).admin_addMember_addMember_tag),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFooter(keyboardIsOpen),
      body: Stack(children: [
        _buildForm(),
      ]),
    );
  }

  _buildFooter(bool keyboardIsOpen) {
    return Visibility(
        visible: !keyboardIsOpen,
        child: Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: StreamBuilder<ApiResponse<bool>>(
                initialData: const ApiResponse.idle(),
                stream: _bloc.addEmployeeStream,
                builder: (context, snapshot) {
                  return snapshot.data!.when(
                    idle: () => _buildButton(),
                    loading: () => const CircularProgressIndicator(
                        color: AppColors.primaryBlue),
                    completed: (val) => Container(),
                    error: (error) => _buildButton(),
                  );
                })));
  }

  _buildForm() {
    var localization = AppLocalizations.of(context);
    return ListView(
      padding: EdgeInsets.only(
        left: primaryHorizontalSpacing,
        right: primaryHorizontalSpacing,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom != 0 ? 0 : 80,
      ),
      children: [
        ToggleButton(
          onRoleChange: (role) {
            switch (role) {
              case kRoleTypeEmployee:
                _bloc.setSelectedRole(kRoleTypeEmployee);
                break;
              case kRoleTypeHR:
                _bloc.setSelectedRole(kRoleTypeHR);
                break;
            }
          },
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFieldTitle(title: localization.employee_employeeID_tag),
            _buildTextField(
                hintText: localization.admin_addMember_hint_employeeId,
                stream: _bloc.employeeId,
                onChanged: (employeeId) =>
                    _bloc.validateEmployeeId(employeeId, context)),
            _buildTextFieldTitle(title: localization.employee_name_tag),
            _buildTextField(
                hintText: localization.admin_addMember_hint_name,
                stream: _bloc.name,
                onChanged: (name) => _bloc.validateName(name, context)),
            _buildTextFieldTitle(title: localization.employee_email_tag),
            _buildTextField(
                hintText: localization.admin_addMember_hint_email,
                stream: _bloc.email,
                onChanged: (email) => _bloc.validateEmail(email, context)),
            _buildTextFieldTitle(title: localization.employee_designation_tag),
            _buildTextField(
                hintText: localization.admin_addMember_hint_designation,
                stream: _bloc.designation,
                onChanged: (designation) =>
                    _bloc.validateDesignation(designation, context)),
            _buildTextFieldTitle(title: localization.employee_dateOfJoin_tag),
            _buildDateOfJoiningButton(),
          ],
        )
      ],
    );
  }

  _buildDateOfJoiningButton(){
    final localization = AppLocalizations.of(context);
    return StreamBuilder<DateTime>(
        stream: _bloc.dateOfJoining,
        builder: (context, snapshot) {
          return TextField(
            onTap: () async {
              DateTime? joiningDate =
                  await pickDate(context: context, initialDate: snapshot.data!);
              _bloc.validateDateOfJoining(joiningDate!);
              _dateController.text = localization.date_format_yMMMd(joiningDate);
            },
            controller: _dateController,
            keyboardType: TextInputType.none,
            cursorColor: Colors.black,
            autocorrect: false,
            style: AppTextStyle.subtitleTextDark,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              hintStyle: AppTextStyle.secondarySubtitle500,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: AppLocalizations.of(context).date_format_yMMMd(snapshot.data!),
            ),
          );
        }
    );
  }

  _buildTextField(
      {required String hintText,
      required Stream<String> stream,
      required void Function(String) onChanged}) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          cursorColor: Colors.black,
          autocorrect: false,
          style: AppTextStyle.subtitleTextDark,
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

  _buildTextFieldTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: AppTextStyle.secondarySubtitle500,
      ),
    );
  }

  _buildButton() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _bloc.validateSubmit,
      builder: (BuildContext context, snapshot) {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: (snapshot.data!)
                      ? AppColors.primaryBlue
                      : AppColors.greyColor,
                ),
                onPressed: () => snapshot.data! ? _bloc.addEmployee() : null,
                child: Text(
                    AppLocalizations.of(context).admin_addMember_button_submit,
                    style: AppTextStyle.subtitleText)));
      },
    );
  }
}
