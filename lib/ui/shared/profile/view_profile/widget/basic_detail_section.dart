import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../admin/members/detail/widget/profile_card.dart';
import '../../../../widget/user_profile_image.dart';
import '../../../../widget/widget_validation.dart';

class BasicDetailSection extends StatelessWidget {
  final Employee employee;

  const BasicDetailSection({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(primaryHorizontalSpacing).copyWith(bottom: 0),
      child: Column(children: [
        ProfileSection(employee: employee),
        const SizedBox(height: 20),
        ContactSection(
          email: employee.email,
          phone: employee.phone,
        ),
        const Divider(),
        IdSection(
          role: employee.role,
          employeeId: employee.employeeId,
        ),
        const Divider()
      ]),
    );
  }
}

class IdSection extends StatelessWidget {
  final Role role;
  final String? employeeId;

  const IdSection({
    super.key,
    required this.role,
    this.employeeId,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextColumn(
          title: localization.employee_role_tag,
          subtitle: localization.user_detail_role_type(role.name),
        ),
        Container(
          height: 60,
          width: 1,
          color: AppColors.lightGreyColor,
        ),
        TextColumn(
          title: localization.employee_employeeID_tag,
          subtitle: employeeId,
        ),
      ],
    );
  }
}

class ContactSection extends StatelessWidget {
  final String? phone;
  final String email;

  const ContactSection({Key? key, this.phone, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValidateWidget(
          isValid: phone.isNotNullOrEmpty,
          child: Row(
            children: [
              const Icon(
                Icons.phone,
                color: AppColors.greyColor,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  phone ?? '',
                  style: AppFontStyle.labelGrey,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(
              Icons.email,
              color: AppColors.greyColor,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                email,
                style: AppFontStyle.labelGrey,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.employee,
  });

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageProfile(imageUrl: employee.imageUrl, radius: 40),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                employee.name,
                style: AppFontStyle.titleDark,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              ValidateWidget(
                isValid: employee.designation.isNotNullOrEmpty,
                child: Text(
                  employee.designation ?? "",
                  style: AppFontStyle.labelGrey,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
