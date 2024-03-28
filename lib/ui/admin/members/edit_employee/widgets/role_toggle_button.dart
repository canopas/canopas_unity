import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/style/app_text_style.dart';

import '../../../../widget/employee_details_textfield.dart';

class ToggleButton extends StatelessWidget {
  final Role role;
  final void Function(Role? role)? onRoleChange;

  const ToggleButton(
      {super.key, required this.onRoleChange, required this.role});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldTitle(title: context.l10n.employee_role_tag),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(Role.values.length, (index) {
              final value = Role.values[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.colorScheme.containerNormal),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Radio.adaptive(
                        value: value,
                        groupValue: role,
                        onChanged: onRoleChange,
                        activeColor: context.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(value.name.capitalize(), style: AppTextStyle.style16)
                  ],
                ),
              );
            })),
      ],
    );
  }
}
