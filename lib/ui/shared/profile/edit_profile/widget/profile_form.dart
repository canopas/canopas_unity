import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/ui/widget/pick_profile_image/pick_user_profile_image.dart';
import '../../../../../data/configs/colors.dart';
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
    Key? key,
    required this.profileImageURL,
    required this.nameController,
    required this.designationController,
    required this.phoneNumberController,
    required this.addressController,
    required this.levelController,
  }) : super(key: key);

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
  const GenderSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final bloc = context.read<EmployeeEditProfileBloc>();
    return BlocBuilder<EmployeeEditProfileBloc, EmployeeEditProfileState>(
        buildWhen: (previous, current) => previous.gender != current.gender,
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: state.gender == Gender.male
                        ? AppColors.darkText
                        : AppColors.secondaryText,
                    backgroundColor: AppColors.textFieldBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.commonBorderRadius,
                    )),
                onPressed: () {
                  bloc.add(EditProfileChangeGenderEvent(gender: Gender.male));
                },
                child: Text(
                  localization.gender_male_tag,
                  style: AppFontStyle.labelRegular,
                ),
              )),
              const SizedBox(
                width: primaryHorizontalSpacing,
              ),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  bloc.add(EditProfileChangeGenderEvent(gender: Gender.female));
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: state.gender == Gender.female
                        ? AppColors.darkText
                        : AppColors.secondaryText,
                    backgroundColor: AppColors.textFieldBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.commonBorderRadius,
                    )),
                child: Text(
                  localization.gender_female_tag,
                  style: AppFontStyle.labelRegular,
                ),
              )),
            ],
          );
        });
  }
}

class DateOfBirthButton extends StatelessWidget {
  const DateOfBirthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final bloc = context.read<EmployeeEditProfileBloc>();
    return BlocBuilder<EmployeeEditProfileBloc, EmployeeEditProfileState>(
      buildWhen: (previous, current) =>
          previous.dateOfBirth != current.dateOfBirth,
      builder: (context, state) => ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.darkText,
              fixedSize: Size(MediaQuery.of(context).size.width, 50),
              alignment: Alignment.centerLeft,
              backgroundColor: AppColors.textFieldBg,
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
              ? Text(
                  localization.date_format_yMMMd(state.dateOfBirth!),
                  style: AppFontStyle.labelRegular,
                )
              : Text(
                  localization.user_settings_edit_select_tag,
                  style: AppFontStyle.labelGrey,
                )),
    );
  }
}
