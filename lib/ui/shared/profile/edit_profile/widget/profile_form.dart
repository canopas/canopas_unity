import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/pick_profile_image/pick_user_profile_image.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../widget/date_time_picker.dart';
import '../../../../widget/employee_details_textfield.dart';
import '../bloc/employee_edit_profile_bloc.dart';
import '../bloc/employee_edit_profile_event.dart';
import '../bloc/employee_edit_profile_state.dart';

class ProfileForm extends StatelessWidget {
  final String? profileImageURL;
  final TextEditingController nameController;
  final TextEditingController designationController;
  final TextEditingController phoneNumberController;
  final TextEditingController addressController;
  final TextEditingController levelController;

  const ProfileForm({
    super.key,
    required this.profileImageURL,
    required this.nameController,
    required this.designationController,
    required this.phoneNumberController,
    required this.addressController,
    required this.levelController,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final bloc = context.read<EmployeeEditProfileBloc>();
    return ListView(
      padding: const EdgeInsets.all(primaryHorizontalSpacing).copyWith(top: 30),
      children: [
        ProfileImagePicker(
          imageURl: profileImageURL,
          onPickImageChange: (String image) => context
              .read<EmployeeEditProfileBloc>()
              .add(ChangeImageEvent(image)),
        ),
        FieldTitle(title: localization.employee_name_tag),
        BlocBuilder<EmployeeEditProfileBloc, EmployeeEditProfileState>(
          buildWhen: (previous, current) =>
              previous.nameError != current.nameError,
          builder: (context, state) => FieldEntry(
            controller: nameController,
            onChanged: (value) =>
                bloc.add(EditProfileNameChangedEvent(name: value)),
            errorText: state.nameError
                ? localization.admin_home_add_member_error_name
                : null,
            hintText: localization.admin_home_add_member_name_hint_text,
          ),
        ),
        FieldTitle(title: localization.employee_designation_tag),
        FieldEntry(
          controller: designationController,
          hintText: localization.admin_home_add_member_designation_hint_text,
        ),
        FieldTitle(title: localization.employee_level_tag),
        FieldEntry(
          controller: levelController,
          hintText: localization.admin_home_add_member_level_hint_text,
        ),
        FieldTitle(title: localization.employee_dateOfBirth_tag),
        const DateOfBirthButton(),
        FieldTitle(title: localization.employee_gender_tag),
        const GenderSelection(),
        FieldTitle(title: localization.employee_mobile_tag),
        FieldEntry(
          controller: phoneNumberController,
          hintText: localization.admin_home_add_member_mobile_number_hint_text,
        ),
        FieldTitle(title: localization.employee_address_tag),
        FieldEntry(
          maxLine: 3,
          controller: addressController,
          hintText: localization.admin_home_add_member_address_hint_text,
        ),
      ],
    );
  }
}

class GenderSelection extends StatelessWidget {
  const GenderSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final bloc = context.read<EmployeeEditProfileBloc>();
    return BlocBuilder<EmployeeEditProfileBloc, EmployeeEditProfileState>(
        buildWhen: (previous, current) => previous.gender != current.gender,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RadioMenuButton<Gender>(
                value: Gender.male,
                groupValue: state.gender,
                onChanged: (Gender? gender) {
                  bloc.add(EditProfileChangeGenderEvent(gender: Gender.male));
                },
                child: Text(
                  localization.gender_male_tag,
                  style: AppTextStyle.style16.copyWith(
                      color: state.gender == Gender.male
                          ? context.colorScheme.primary
                          : context.colorScheme.textPrimary),
                ),
              ),
              RadioMenuButton<Gender>(
                value: Gender.female,
                groupValue: state.gender,
                onChanged: (Gender? gender) {
                  bloc.add(EditProfileChangeGenderEvent(gender: Gender.female));
                },
                child: Text(
                  localization.gender_female_tag,
                  style: AppTextStyle.style16.copyWith(
                      color: state.gender == Gender.female
                          ? context.colorScheme.primary
                          : context.colorScheme.textPrimary),
                ),
              )
              // Expanded(
              //     child: ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       elevation: 0,
              //       shadowColor: context.colorScheme.containerNormal,
              //       surfaceTintColor: context.colorScheme.containerNormal,
              //       foregroundColor: state.gender == Gender.male
              //           ? context.colorScheme.textPrimary
              //           : context.colorScheme.textSecondary,
              //       backgroundColor: context.colorScheme.containerNormal,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: AppTheme.commonBorderRadius,
              //       )),
              //   onPressed: () {
              //     bloc.add(EditProfileChangeGenderEvent(gender: Gender.male));
              //   },
              //   child: Text(
              //     localization.gender_male_tag,
              //     style: AppTextStyle.style16
              //         .copyWith(color: context.colorScheme.textPrimary),
              //   ),
              // )),
              // const SizedBox(
              //   width: primaryHorizontalSpacing,
              // ),
              // Expanded(
              //     child: ElevatedButton(
              //   onPressed: () {
              //     bloc.add(EditProfileChangeGenderEvent(gender: Gender.female));
              //   },
              //   style: ElevatedButton.styleFrom(
              //     elevation: 0,
              //     shadowColor: context.colorScheme.containerNormal,
              //     surfaceTintColor: context.colorScheme.containerNormal,
              //       foregroundColor: state.gender == Gender.female
              //           ? context.colorScheme.textPrimary
              //           : context.colorScheme.textSecondary,
              //       backgroundColor: context.colorScheme.containerNormal,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: AppTheme.commonBorderRadius,
              //       )),
              //   child: Text(
              //     localization.gender_female_tag,
              //     style: AppTextStyle.style16
              //         .copyWith(color: context.colorScheme.textPrimary),
              //   ),
              // )),
            ],
          );
        });
  }
}

class DateOfBirthButton extends StatelessWidget {
  const DateOfBirthButton({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final bloc = context.read<EmployeeEditProfileBloc>();
    return BlocBuilder<EmployeeEditProfileBloc, EmployeeEditProfileState>(
      buildWhen: (previous, current) =>
          previous.dateOfBirth != current.dateOfBirth,
      builder: (context, state) => ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              shadowColor: context.colorScheme.containerNormal,
              surfaceTintColor: context.colorScheme.containerNormal,
              foregroundColor: context.colorScheme.textSecondary,
              fixedSize: Size(MediaQuery.of(context).size.width, 50),
              alignment: Alignment.centerLeft,
              backgroundColor: context.colorScheme.containerNormal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: () async {
            DateTime? pickedDate = await pickDate(
                context: context,
                initialDate: state.dateOfBirth ?? DateTime.now());
            bloc.add(
                EditProfileChangeDateOfBirthEvent(dateOfBirth: pickedDate));
          },
          child: state.dateOfBirth != null
              ? Text(localization.date_format_yMMMd(state.dateOfBirth!),
                  style: AppTextStyle.style16
                      .copyWith(color: context.colorScheme.textPrimary))
              : Text(
                  localization.user_settings_edit_select_tag,
                  style: AppTextStyle.style16
                      .copyWith(color: context.colorScheme.textPrimary),
                )),
    );
  }
}
