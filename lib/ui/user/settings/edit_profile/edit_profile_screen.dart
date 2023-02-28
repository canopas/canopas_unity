import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/settings/edit_profile/widget/profile_form.dart';

import '../../../../configs/colors.dart';
import '../../../../model/employee/employee.dart';
import '../../../../widget/app_app_bar.dart';
import '../../../../widget/error_snack_bar.dart';
import 'bloc/emloyee_edit_profile_bloc.dart';
import 'bloc/employee_edit_profile_event.dart';
import 'bloc/employee_edit_profile_state.dart';

class EmployeeEditProfilePage extends StatelessWidget {
  final Employee employee;

  const EmployeeEditProfilePage({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployeeEditProfileBloc>()
        ..add(EditProfileInitialLoadEvent(
            dateOfBirth: employee.dateOfBirth, gender: employee.gender)),
      child: EmployeeEditProfileScreen(employee: employee),
    );
  }
}

class EmployeeEditProfileScreen extends StatefulWidget {
  final Employee employee;

  const EmployeeEditProfileScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  State<EmployeeEditProfileScreen> createState() =>
      _EmployeeEditProfileScreenState();
}

class _EmployeeEditProfileScreenState extends State<EmployeeEditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController levelController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.employee.name;
    designationController.text = widget.employee.designation;
    phoneNumberController.text = widget.employee.phone ?? "";
    addressController.text = widget.employee.address ?? "";
    bloodGroupController.text = widget.employee.bloodGroup ?? "";
    levelController.text = widget.employee.level ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppAppBar(
        onBack: () {
          context.pop();
        },
        bottomTitlePadding: 0,
        title: AppLocalizations.of(context).edit_tag,
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(primaryVerticalSpacing),
              ),
              onPressed: () {
                context
                    .read<EmployeeEditProfileBloc>()
                    .add(EditProfileUpdateProfileEvent(
                      address: addressController.text,
                      bloodGroup: bloodGroupController.text,
                      level: levelController.text,
                      name: nameController.text,
                      designation: designationController.text,
                      phoneNumber: phoneNumberController.text,
                    ));
              },
              child: Text(
                AppLocalizations.of(context).save_tag,
                style: AppTextStyle.subtitleTextDark,
              ))
        ],
      ),
      body: BlocListener<EmployeeEditProfileBloc, EmployeeEditProfileState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == EmployeeProfileState.failure) {
            showSnackBar(context: context, error: state.error);
          } else if (state.status == EmployeeProfileState.success) {
            context.pop();
          }
        },
        child: ProfileForm(
          profileImageURL: widget.employee.imageUrl,
          nameController: nameController,
          levelController: levelController,
          designationController: designationController,
          addressController: addressController,
          bloodGroupController: bloodGroupController,
          phoneNumberController: phoneNumberController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    designationController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    bloodGroupController.dispose();
    levelController.dispose();
    super.dispose();
  }
}