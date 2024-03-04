import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/colors.dart';
import '../../../../../data/configs/space_constant.dart';
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
        IdSection(
          role: employee.role,
          employeeId: employee.employeeId,
        ),
        const Divider(
          color: containerHighColor,
        )
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
          color: containerHighColor,
        ),
        TextColumn(
          title: localization.employee_employeeID_tag,
          subtitle: employeeId,
        ),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ImageProfile(imageUrl: employee.imageUrl, radius: 40),
        ),
        Text(
          employee.name,
          style: AppTextStyle.style20
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        ValidateWidget(
          isValid: employee.designation.isNotNullOrEmpty,
          child: Text(
            employee.designation ?? "",
            style: AppTextStyle.style14
                .copyWith(color: context.colorScheme.textDisabled),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
