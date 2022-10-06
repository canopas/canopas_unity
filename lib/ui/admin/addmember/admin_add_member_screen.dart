import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/bloc/admin/employee/add_memeber_bloc.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';
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
    var _localization = AppLocalizations.of(context);
    return ListView(
      padding:  EdgeInsets.only(
        left: primaryHorizontalSpacing,
        right: primaryHorizontalSpacing,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom != 0?0:80,
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
            _buildTextFieldTitle(title: _localization.employee_employeeID_tag),
            _buildTextField(
                hintText: _localization.admin_addMember_hint_employeeId,
                stream: _bloc.employeeId,
                onChanged: (employeeId) =>
                    _bloc.validateEmployeeId(employeeId, context)),
            _buildTextFieldTitle(title: _localization.employee_name_tag),
            _buildTextField(
                hintText: _localization.admin_addMember_hint_name,
                stream: _bloc.name,
                onChanged: (name) => _bloc.validateName(name, context)),
            _buildTextFieldTitle(title: _localization.employee_email_tag),
            _buildTextField(
                hintText: _localization.admin_addMember_hint_email,
                stream: _bloc.email,
                onChanged: (email) => _bloc.validateEmail(email, context)),
            _buildTextFieldTitle(title: _localization.employee_designation_tag),
            _buildTextField(
                hintText: _localization.admin_addMember_hint_designation,
                stream: _bloc.designation,
                onChanged: (designation) =>
                    _bloc.validateDesignation(designation, context)),
            _buildTextFieldTitle(title: _localization.employee_dateOfJoin_tag),
            _buildDateOfJoiningButton(),
          ],
        )
      ],
    );
  }

  _buildDateOfJoiningButton(){
    return StreamBuilder<DateTime>(
        initialData: _bloc.currentTime,
        stream: _bloc.dateOfJoining,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(bottom: primaryHorizontalSpacing),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  elevation: 0,
                  backgroundColor: AppColors.whiteColor,
                  fixedSize: Size(MediaQuery.of(context).size.width, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: AppColors.secondaryText),
                  ),
                ),
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  DateTime _joiningDate = await pickDate(
                      context: context, initialDate: snapshot.data!);
                  _bloc.validateDateOfJoining(_joiningDate);
                },
                child:  Text(AppLocalizations.of(context).date_format_yMMMd(snapshot.data!),style: AppTextStyle.secondarySubtitle500,)),
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
                  backgroundColor: (snapshot.data ?? false)
                      ? AppColors.primaryBlue
                      : AppColors.greyColor,
                ),
                onPressed: () =>
                    (snapshot.data ?? false) ? _bloc.addEmployee() : null,
                child: Text(
                    AppLocalizations.of(context).admin_addMember_button_submit,
                    style: AppTextStyle.subtitleText)));
      },
    );
  }
}
