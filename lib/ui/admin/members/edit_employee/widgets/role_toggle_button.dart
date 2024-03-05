import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/style/app_text_style.dart';

class ToggleButton extends StatelessWidget {
  final Role role;
  final Function(Role role) onRoleChange;

  const ToggleButton({super.key, required this.onRoleChange, required this.role});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width *
        (90 / roleTypeSelectionToggleButtonAlignment.length / 100);
    var localization = AppLocalizations.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 60.0,
        decoration: BoxDecoration(
          color: context.colorScheme.containerNormal,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(
                  roleTypeSelectionToggleButtonAlignment[role] ?? -1, 0),
              curve: Curves.ease,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: context.colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
            ...roleTypeSelectionToggleButtonAlignment.entries
                .map(
                  (roleTypeAlignment) => GestureDetector(
                    onTap: () => onRoleChange(roleTypeAlignment.key),
                    child: Align(
                      alignment: Alignment(roleTypeAlignment.value, 0),
                      child: Container(
                        width: width,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                            localization.user_detail_role_type(
                                roleTypeAlignment.key.name),
                            textAlign: TextAlign.start,
                            style: AppTextStyle.style14.copyWith(
                                color: context.colorScheme.textPrimary,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                )
                
          ],
        ),
      ),
    );
  }
}

Map<Role, double> roleTypeSelectionToggleButtonAlignment = {
  Role.employee: -1,
  Role.hr: 0,
  Role.admin: 1,
};
